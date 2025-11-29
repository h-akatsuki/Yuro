import 'package:flutter/foundation.dart';
import 'package:asmrapp/core/audio/cache/audio_cache_manager.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:asmrapp/core/subtitle/cache/subtitle_cache_manager.dart';

class CacheManagerViewModel extends ChangeNotifier {
  bool _isLoading = false;
  int _audioCacheSize = 0;
  int _subtitleCacheSize = 0;
  String? _errorDetail;
  CacheOperation? _lastFailedOperation;

  bool get isLoading => _isLoading;
  int get audioCacheSize => _audioCacheSize;
  int get subtitleCacheSize => _subtitleCacheSize;
  int get totalCacheSize => _audioCacheSize + _subtitleCacheSize;
  String? get error => _errorDetail;
  String? get errorDetail => _errorDetail;
  CacheOperation? get lastFailedOperation => _lastFailedOperation;

  // 格式化缓存大小显示
  String _formatSize(int size) {
    if (size < 1024) return '${size}B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(2)}KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(2)}MB';
  }

  String get audioCacheSizeFormatted => _formatSize(_audioCacheSize);
  String get subtitleCacheSizeFormatted => _formatSize(_subtitleCacheSize);
  String get totalCacheSizeFormatted => _formatSize(totalCacheSize);

  // 加载缓存大小
  Future<void> loadCacheSize() async {
    try {
      _isLoading = true;
      _errorDetail = null;
      _lastFailedOperation = null;
      notifyListeners();

      // 获取音频缓存大小
      _audioCacheSize = await AudioCacheManager.getCacheSize();
      // 获取字幕缓存大小
      _subtitleCacheSize = await SubtitleCacheManager.getSize();

      _errorDetail = null;
    } catch (e) {
      AppLogger.error('加载缓存大小失败', e);
      _errorDetail = e.toString();
      _lastFailedOperation = CacheOperation.load;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 清理音频缓存
  Future<void> clearAudioCache() async {
    try {
      _isLoading = true;
      _errorDetail = null;
      _lastFailedOperation = null;
      notifyListeners();

      await AudioCacheManager.cleanCache();
      await loadCacheSize();
      _errorDetail = null;
    } catch (e) {
      AppLogger.error('清理音频缓存失败', e);
      _errorDetail = e.toString();
      _lastFailedOperation = CacheOperation.clearAudio;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 清理字幕缓存
  Future<void> clearSubtitleCache() async {
    try {
      _isLoading = true;
      _errorDetail = null;
      _lastFailedOperation = null;
      notifyListeners();

      await SubtitleCacheManager.clearCache();
      await loadCacheSize();
      _errorDetail = null;
    } catch (e) {
      AppLogger.error('清理字幕缓存失败', e);
      _errorDetail = e.toString();
      _lastFailedOperation = CacheOperation.clearSubtitle;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // 清理所有缓存
  Future<void> clearAllCache() async {
    try {
      _isLoading = true;
      _errorDetail = null;
      _lastFailedOperation = null;
      notifyListeners();

      await Future.wait([
        AudioCacheManager.cleanCache(),
        SubtitleCacheManager.clearCache(),
      ]);

      await loadCacheSize();
      _errorDetail = null;
    } catch (e) {
      AppLogger.error('清理缓存失败', e);
      _errorDetail = e.toString();
      _lastFailedOperation = CacheOperation.clearAll;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

enum CacheOperation {
  load,
  clearAudio,
  clearSubtitle,
  clearAll,
}
