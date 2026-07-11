import 'package:asmrapp/core/download/bulk_save_request_executor.dart';
import 'package:asmrapp/data/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('spaces request starts by at least one second', () async {
    final clock = _FakeClock();
    final executor = clock.executor();
    final starts = <DateTime>[];

    await executor.run(
      operation: 'first',
      request: () async {
        starts.add(clock.now);
        return 1;
      },
    );
    await executor.run(
      operation: 'second',
      request: () async {
        starts.add(clock.now);
        return 2;
      },
    );

    expect(starts[1].difference(starts[0]), const Duration(seconds: 1));
  });

  test('429 honors Retry-After before retrying', () async {
    final clock = _FakeClock();
    final executor = clock.executor();
    var attempts = 0;

    final result = await executor.run(
      operation: 'rate limited',
      request: () async {
        attempts++;
        if (attempts == 1) {
          final dioError = _responseError(
            429,
            headers: Headers.fromMap(<String, List<String>>{
              'retry-after': <String>['3'],
            }),
          );
          throw ApiRequestException('rate limited', dioError);
        }
        return 'ok';
      },
    );

    expect(result, 'ok');
    expect(attempts, 2);
    expect(clock.elapsed, const Duration(seconds: 3));
  });

  test('transient server errors use exponential backoff', () async {
    final clock = _FakeClock();
    final executor = clock.executor();
    var attempts = 0;

    final result = await executor.run(
      operation: 'temporarily unavailable',
      request: () async {
        attempts++;
        if (attempts <= 2) throw _responseError(503);
        return 'ok';
      },
    );

    expect(result, 'ok');
    expect(attempts, 3);
    expect(clock.elapsed, const Duration(seconds: 3));
  });

  test('non-retryable client errors fail immediately', () async {
    final clock = _FakeClock();
    final executor = clock.executor();
    var attempts = 0;

    await expectLater(
      executor.run<void>(
        operation: 'not found',
        request: () async {
          attempts++;
          throw _responseError(404);
        },
      ),
      throwsA(isA<DioException>()),
    );

    expect(attempts, 1);
    expect(clock.elapsed, Duration.zero);
  });
}

DioException _responseError(int statusCode, {Headers? headers}) {
  final requestOptions = RequestOptions(path: '/bulk-save-test');
  return DioException(
    requestOptions: requestOptions,
    response: Response<void>(
      requestOptions: requestOptions,
      statusCode: statusCode,
      headers: headers,
    ),
    type: DioExceptionType.badResponse,
  );
}

class _FakeClock {
  final DateTime initial = DateTime.utc(2026);
  late DateTime now = initial;

  Duration get elapsed => now.difference(initial);

  BulkSaveRequestExecutor executor() => BulkSaveRequestExecutor(
    now: () => now,
    delay: (duration) async {
      now = now.add(duration);
    },
  );
}
