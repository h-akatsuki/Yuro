import 'dart:io';

import 'package:asmrapp/data/services/api_service.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:dio/dio.dart';

typedef BulkSaveDelay = Future<void> Function(Duration duration);

class BulkSaveRequestExecutor {
  static const int _maxRateLimitRetries = 5;
  static const int _maxTransientRetries = 3;
  static const Duration _cancellationPollInterval = Duration(milliseconds: 250);

  final Duration minimumInterval;
  final DateTime Function() _now;
  final BulkSaveDelay _delay;

  DateTime? _lastRequestStartedAt;

  BulkSaveRequestExecutor({
    this.minimumInterval = const Duration(seconds: 1),
    DateTime Function()? now,
    BulkSaveDelay? delay,
  }) : _now = now ?? DateTime.now,
       _delay = delay ?? ((duration) => Future<void>.delayed(duration));

  Future<T> run<T>({
    required String operation,
    required Future<T> Function() request,
    CancelToken? cancelToken,
  }) async {
    var retryNumber = 0;
    while (true) {
      await _waitForRequestSlot(cancelToken);
      _throwIfCancelled(cancelToken);
      _lastRequestStartedAt = _now();

      try {
        return await request();
      } catch (error) {
        if (_isCancellation(error)) rethrow;
        retryNumber++;
        final retryDelay = _retryDelay(error, retryNumber);
        if (retryDelay == null) rethrow;

        AppLogger.warning(
          '一括保存APIを再試行します: $operation '
          '($retryNumber回目、${retryDelay.inMilliseconds}ms後)',
        );
        await _wait(retryDelay, cancelToken);
      }
    }
  }

  Future<void> _waitForRequestSlot(CancelToken? cancelToken) async {
    final lastStartedAt = _lastRequestStartedAt;
    if (lastStartedAt == null || minimumInterval <= Duration.zero) return;

    final elapsed = _now().difference(lastStartedAt);
    final remaining = minimumInterval - elapsed;
    if (remaining > Duration.zero) {
      await _wait(remaining, cancelToken);
    }
  }

  Duration? _retryDelay(Object error, int retryNumber) {
    final dioError = _dioError(error);
    if (dioError == null) return null;

    final statusCode = dioError.response?.statusCode;
    if (statusCode == HttpStatus.tooManyRequests) {
      if (retryNumber > _maxRateLimitRetries) return null;
      final backoff = _exponentialBackoff(retryNumber);
      final retryAfter = _retryAfter(dioError);
      return retryAfter != null && retryAfter > backoff ? retryAfter : backoff;
    }

    final retryableStatus =
        statusCode == HttpStatus.requestTimeout ||
        statusCode == 425 ||
        statusCode == HttpStatus.internalServerError ||
        statusCode == HttpStatus.badGateway ||
        statusCode == HttpStatus.serviceUnavailable ||
        statusCode == HttpStatus.gatewayTimeout;
    final retryableTransport = switch (dioError.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      DioExceptionType.transformTimeout ||
      DioExceptionType.connectionError ||
      DioExceptionType.unknown => true,
      DioExceptionType.badCertificate ||
      DioExceptionType.badResponse ||
      DioExceptionType.cancel => false,
    };

    if (!retryableStatus && !retryableTransport) return null;
    if (retryNumber > _maxTransientRetries) return null;
    return _exponentialBackoff(retryNumber);
  }

  DioException? _dioError(Object error) => switch (error) {
    DioException dioError => dioError,
    ApiRequestException apiError => apiError.cause,
    _ => null,
  };

  Duration _exponentialBackoff(int retryNumber) =>
      Duration(seconds: 1 << (retryNumber - 1));

  Duration? _retryAfter(DioException error) {
    final value = error.response?.headers.value('retry-after')?.trim();
    if (value == null || value.isEmpty) return null;

    final seconds = int.tryParse(value);
    if (seconds != null) {
      return Duration(seconds: seconds < 0 ? 0 : seconds);
    }

    try {
      final retryAt = HttpDate.parse(value);
      final remaining = retryAt.difference(_now().toUtc());
      return remaining > Duration.zero ? remaining : Duration.zero;
    } on FormatException {
      return null;
    }
  }

  Future<void> _wait(Duration duration, CancelToken? cancelToken) async {
    var remaining = duration;
    while (remaining > Duration.zero) {
      _throwIfCancelled(cancelToken);
      final step = remaining > _cancellationPollInterval
          ? _cancellationPollInterval
          : remaining;
      await _delay(step);
      remaining -= step;
    }
    _throwIfCancelled(cancelToken);
  }

  void _throwIfCancelled(CancelToken? cancelToken) {
    if (cancelToken?.isCancelled != true) return;
    final cancellation = cancelToken?.cancelError;
    if (cancellation != null) throw cancellation;
    throw DioException.requestCancelled(
      requestOptions: RequestOptions(path: 'bulk-save'),
      reason: 'Bulk save cancelled',
      stackTrace: StackTrace.current,
    );
  }

  bool _isCancellation(Object error) =>
      error is DioException && error.type == DioExceptionType.cancel;
}
