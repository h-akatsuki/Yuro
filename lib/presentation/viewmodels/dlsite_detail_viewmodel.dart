import 'package:asmrapp/data/models/dlsite/dlsite_work_detail.dart';
import 'package:asmrapp/data/services/dlsite_service.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DlsiteDetailViewModel extends ChangeNotifier {
  final Uri pageUrl;
  final DlsiteService _service;
  CancelToken _cancelToken = CancelToken();

  DlsiteWorkDetail? _detail;
  Object? _error;
  bool _isLoading = false;
  bool _disposed = false;

  DlsiteDetailViewModel({required this.pageUrl, required DlsiteService service})
    : _service = service;

  DlsiteWorkDetail? get detail => _detail;
  Object? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    if (_isLoading) return;
    _isLoading = true;
    _error = null;
    _notify();
    try {
      _detail = await _service.getWorkDetail(
        pageUrl,
        cancelToken: _cancelToken,
      );
    } catch (error, stackTrace) {
      if (error is DioException && error.type == DioExceptionType.cancel) {
        return;
      }
      AppLogger.error('DLsite作品情報の取得に失敗', error, stackTrace);
      _error = error;
    } finally {
      _isLoading = false;
      _notify();
    }
  }

  Future<void> reload() async {
    if (_isLoading) return;
    _cancelToken.cancel();
    _cancelToken = CancelToken();
    await load();
  }

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _cancelToken.cancel();
    super.dispose();
  }
}
