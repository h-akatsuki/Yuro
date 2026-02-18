import 'dart:io';

import 'package:asmrapp/data/models/playlists_with_exist_statu/pagination.dart';
import 'package:asmrapp/data/models/playlists_with_exist_statu/playlist.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/data/models/files/files.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/data/services/api_service.dart';
import 'package:asmrapp/core/audio/i_audio_player_service.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:asmrapp/core/audio/models/playback_context.dart';
import 'package:asmrapp/widgets/detail/playlist_selection_dialog.dart';
import 'package:asmrapp/data/models/mark_status.dart';
import 'package:asmrapp/widgets/detail/mark_selection_dialog.dart';
import 'package:dio/dio.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/common/extensions/mark_status_localizations.dart';
import 'package:path_provider/path_provider.dart';

enum PlaybackError {
  unsupportedType,
  missingUrl,
  filesNotLoaded,
  failed,
}

enum FilePreviewError {
  unsupportedType,
  missingUrl,
  failed,
}

class PlaybackException implements Exception {
  final PlaybackError error;
  final String? detail;
  final Object? originalError;

  const PlaybackException(
    this.error, {
    this.detail,
    this.originalError,
  });
}

class FilePreviewException implements Exception {
  final FilePreviewError error;
  final String? detail;
  final Object? originalError;

  const FilePreviewException(
    this.error, {
    this.detail,
    this.originalError,
  });
}

class DownloadBatchResult {
  final int successCount;
  final int failedCount;
  final String saveDirectoryPath;

  const DownloadBatchResult({
    required this.successCount,
    required this.failedCount,
    required this.saveDirectoryPath,
  });
}

class DetailViewModel extends ChangeNotifier {
  late final ApiService _apiService;
  late final IAudioPlayerService _audioService;
  final Work work;

  Files? _files;
  bool _isLoading = false;
  String? _error;
  bool _disposed = false;

  List<Work> _recommendedWorks = [];
  bool _hasRecommendations = false;
  bool _loadingRecommendations = false;
  String? _recommendationsError;

  // 收藏夹相关状态
  bool _loadingPlaylists = false;
  String? _playlistsError;
  List<Playlist>? _playlists;
  Pagination? _playlistsPagination;

  bool _loadingFavorite = false;
  bool get loadingFavorite => _loadingFavorite;

  MarkStatus? _currentMarkStatus;
  MarkStatus? get currentMarkStatus => _currentMarkStatus;

  bool _loadingMark = false;
  bool get loadingMark => _loadingMark;
  bool _downloadingFiles = false;
  bool get downloadingFiles => _downloadingFiles;

  // 添加取消标记
  final _cancelToken = CancelToken();

  DetailViewModel({
    required this.work,
  }) {
    _audioService = GetIt.I<IAudioPlayerService>();
    _apiService = GetIt.I<ApiService>();
    loadRecommendationsPreview();
  }

  Files? get files => _files;
  bool get isLoading => _isLoading;
  String? get error => _error;
  List<Work> get recommendedWorks => _recommendedWorks;
  bool get hasRecommendations => _hasRecommendations;
  bool get loadingRecommendations => _loadingRecommendations;
  String? get recommendationsError => _recommendationsError;

  // 收藏夹相关 getters
  bool get loadingPlaylists => _loadingPlaylists;
  String? get playlistsError => _playlistsError;
  List<Playlist>? get playlists => _playlists;
  int? get playlistsTotalPages => _playlistsPagination?.totalCount != null &&
          _playlistsPagination?.pageSize != null
      ? (_playlistsPagination!.totalCount! / _playlistsPagination!.pageSize!)
          .ceil()
      : null;

  Future<void> loadRecommendationsPreview() async {
    if (_loadingRecommendations) return;

    _loadingRecommendations = true;
    _recommendationsError = null;
    notifyListeners();

    try {
      final response = await _apiService.getItemNeighbors(
        itemId: work.id.toString(),
        page: 1,
      );
      _recommendedWorks = response.works
          .where((recommendedWork) => recommendedWork.id != work.id)
          .toList();
      _hasRecommendations = (response.pagination.totalCount ?? 0) > 0 ||
          _recommendedWorks.isNotEmpty;
    } catch (e) {
      AppLogger.error('检查相关推荐失败', e);
      _recommendedWorks = [];
      _hasRecommendations = false;
      _recommendationsError = e.toString();
    } finally {
      if (!_disposed) {
        _loadingRecommendations = false;
        notifyListeners();
      }
    }
  }

  Future<void> loadFiles() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      AppLogger.info('开始加载作品文件: ${work.id}');
      _files = await _apiService.getWorkFiles(
        work.id.toString(),
        cancelToken: _cancelToken,
      );
      AppLogger.info('文件加载成功: ${work.id}');
    } catch (e) {
      if (e is! DioException || e.type != DioExceptionType.cancel) {
        AppLogger.info('加载文件失败，用户取消请求');
        _error = e.toString();
      }
    } finally {
      if (!_disposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> playFile(Child file, BuildContext context) async {
    if (!FilePreviewUtils.isAudio(file)) {
      throw PlaybackException(
        PlaybackError.unsupportedType,
        detail: file.type ?? file.title,
      );
    }

    if (file.mediaDownloadUrl == null) {
      throw const PlaybackException(PlaybackError.missingUrl);
    }

    if (_files == null) {
      throw const PlaybackException(PlaybackError.filesNotLoaded);
    }

    try {
      final playbackContext = PlaybackContext(
        work: work,
        files: _files!,
        currentFile: file,
      );

      await _audioService.playWithContext(playbackContext);
    } catch (e) {
      if (!_disposed) {
        AppLogger.error('播放失败', e);
      }
      throw PlaybackException(
        PlaybackError.failed,
        detail: e.toString(),
        originalError: e,
      );
    }
  }

  bool canPreviewFile(Child file) {
    return FilePreviewUtils.canPreview(file);
  }

  Future<String> loadTextPreview(Child file) async {
    if (!FilePreviewUtils.isText(file)) {
      throw FilePreviewException(
        FilePreviewError.unsupportedType,
        detail: file.type ?? file.title,
      );
    }

    if (file.mediaDownloadUrl == null || file.mediaDownloadUrl!.isEmpty) {
      throw const FilePreviewException(FilePreviewError.missingUrl);
    }

    try {
      return await _apiService.getTextFileContent(
        file.mediaDownloadUrl!,
        cancelToken: _cancelToken,
      );
    } catch (e) {
      throw FilePreviewException(
        FilePreviewError.failed,
        detail: e.toString(),
        originalError: e,
      );
    }
  }

  /// 加载收藏夹列表
  Future<void> loadPlaylists({int page = 1}) async {
    if (_loadingPlaylists) return;

    _loadingPlaylists = true;
    _playlistsError = null;
    notifyListeners();

    try {
      final response = await _apiService.getWorkExistStatusInPlaylists(
        workId: work.id.toString(),
        page: page,
      );

      _playlists = response.playlists;
      _playlistsPagination = response.pagination;
      AppLogger.info('收藏夹列表加载成功: ${_playlists?.length ?? 0}个收藏夹');
    } catch (e) {
      AppLogger.error('加载收藏夹列表失败', e);
      _playlistsError = e.toString();
    } finally {
      _loadingPlaylists = false;
      notifyListeners();
    }
  }

  Future<void> showPlaylistsDialog(BuildContext context) async {
    _loadingFavorite = true;
    notifyListeners();

    try {
      await loadPlaylists();
      _loadingFavorite = false;
      notifyListeners();

      if (!context.mounted) return;

      await showDialog(
        context: context,
        builder: (context) => PlaylistSelectionDialog(
          playlists: playlists,
          isLoading: loadingPlaylists,
          error: playlistsError,
          onRetry: () => loadPlaylists(),
          onPlaylistTap: (playlist) async {
            try {
              await togglePlaylistWork(playlist);
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      context.l10n.operationFailed(e.toString()),
                    ),
                  ),
                );
              }
            }
          },
        ),
      );
    } catch (e) {
      _loadingFavorite = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> togglePlaylistWork(Playlist playlist) async {
    try {
      if (playlist.exist ?? false) {
        await _apiService.removeWorkFromPlaylist(
          playlistId: playlist.id!,
          workId: work.id.toString(),
        );
      } else {
        await _apiService.addWorkToPlaylist(
          playlistId: playlist.id!,
          workId: work.id.toString(),
        );
      }

      // 更新本地收藏夹状态
      final index = _playlists?.indexWhere((p) => p.id == playlist.id);
      if (index != null && index != -1) {
        _playlists = List<Playlist>.from(_playlists!)
          ..[index] = playlist.copyWith(exist: !(playlist.exist ?? false));
        notifyListeners();
      }

      final action = (playlist.exist ?? false) ? '移除' : '添加';
      AppLogger.info('$action收藏成功: ${playlist.name}');
    } catch (e) {
      AppLogger.error('切换收藏状态失败', e);
      rethrow;
    }
  }

  Future<void> updateMarkStatus(MarkStatus status) async {
    _loadingMark = true;
    notifyListeners();

    try {
      await _apiService.updateWorkMarkStatus(
        work.id.toString(),
        _apiService.convertMarkStatusToApi(status),
      );

      _currentMarkStatus = status;
      AppLogger.info('更新标记状态成功: ${status.label}');
    } catch (e) {
      AppLogger.error('更新标记状态失败', e);
      rethrow;
    } finally {
      _loadingMark = false;
      notifyListeners();
    }
  }

  Future<DownloadBatchResult> downloadFiles(List<Child> files) async {
    _downloadingFiles = true;
    notifyListeners();

    var successCount = 0;
    var failedCount = 0;
    var saveDirectoryPath = '';

    try {
      final saveDirectory = await _resolveDownloadDirectory();
      saveDirectoryPath = saveDirectory.path;

      for (final file in files) {
        final downloadUrl = file.mediaDownloadUrl;
        if (downloadUrl == null || downloadUrl.isEmpty) {
          failedCount++;
          continue;
        }

        final safeFileName = _sanitizeFileName(file.title);
        final savePath =
            await _createUniqueSavePath(saveDirectory, safeFileName);

        try {
          await _apiService.downloadFileToPath(
            downloadUrl,
            savePath,
            cancelToken: _cancelToken,
          );
          successCount++;
        } catch (e) {
          failedCount++;
          AppLogger.error('下载文件失败: ${file.title}', e);
        }
      }
    } finally {
      _downloadingFiles = false;
      if (!_disposed) {
        notifyListeners();
      }
    }

    return DownloadBatchResult(
      successCount: successCount,
      failedCount: failedCount,
      saveDirectoryPath: saveDirectoryPath,
    );
  }

  Future<Directory> _resolveDownloadDirectory() async {
    final candidateBaseDirectories = <Directory?>[];

    try {
      candidateBaseDirectories.add(await getDownloadsDirectory());
    } catch (_) {
      candidateBaseDirectories.add(null);
    }
    candidateBaseDirectories.add(await getApplicationDocumentsDirectory());

    final workFolderName = _sanitizeFileName(
      (work.sourceId?.trim().isNotEmpty ?? false)
          ? work.sourceId!
          : 'work_${work.id ?? 'unknown'}',
    );

    for (final baseDirectory in candidateBaseDirectories) {
      if (baseDirectory == null) continue;

      try {
        final rootDirectory = Directory(
          '${baseDirectory.path}${Platform.pathSeparator}asmr_downloads',
        );
        if (!await rootDirectory.exists()) {
          await rootDirectory.create(recursive: true);
        }

        final workDirectory = Directory(
          '${rootDirectory.path}${Platform.pathSeparator}$workFolderName',
        );
        if (!await workDirectory.exists()) {
          await workDirectory.create(recursive: true);
        }

        return workDirectory;
      } catch (e) {
        AppLogger.error('创建下载目录失败: ${baseDirectory.path}', e);
      }
    }

    throw Exception('无法创建下载目录');
  }

  Future<String> _createUniqueSavePath(
    Directory directory,
    String fileName,
  ) async {
    final dotIndex = fileName.lastIndexOf('.');
    final baseName = dotIndex > 0 ? fileName.substring(0, dotIndex) : fileName;
    final extension = dotIndex > 0 ? fileName.substring(dotIndex) : '';

    var candidateName = fileName;
    var counter = 1;
    while (await File(
      '${directory.path}${Platform.pathSeparator}$candidateName',
    ).exists()) {
      candidateName = '$baseName ($counter)$extension';
      counter++;
    }

    return '${directory.path}${Platform.pathSeparator}$candidateName';
  }

  String _sanitizeFileName(String? original) {
    final normalized = (original ?? '').trim();
    if (normalized.isEmpty) {
      return 'file';
    }
    return normalized.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  void showMarkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => MarkSelectionDialog(
        currentStatus: _currentMarkStatus,
        loading: _loadingMark,
        onMarkSelected: (status) async {
          try {
            await updateMarkStatus(status);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.l10n
                        .markUpdated(status.localizedLabel(context.l10n)),
                  ),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.markFailed(e.toString())),
                ),
              );
            }
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    // 取消所有正在进行的请求
    _cancelToken.cancel('ViewModel disposed');
    _disposed = true;
    super.dispose();
  }
}
