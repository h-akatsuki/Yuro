import 'dart:io';

import 'package:asmrapp/core/download/download_request_item.dart';
import 'package:asmrapp/data/models/playlists_with_exist_statu/pagination.dart';
import 'package:asmrapp/data/models/playlists_with_exist_statu/playlist.dart';
import 'package:asmrapp/data/repositories/auth_repository.dart';
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
import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/core/download/download_progress_manager.dart';
import 'package:background_downloader/background_downloader.dart';
import 'package:dio/dio.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/common/extensions/mark_status_localizations.dart';

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
  late final DownloadDirectoryController _downloadDirectoryController;
  late final DownloadProgressManager _downloadProgressManager;
  late final AuthRepository _authRepository;
  late final FileDownloader _fileDownloader;
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
  int? _currentRating;
  int? get currentRating => _currentRating;
  bool _loadingRating = false;
  bool get loadingRating => _loadingRating;
  bool _downloadingFiles = false;
  bool get downloadingFiles => _downloadingFiles;

  // 添加取消标记
  final _cancelToken = CancelToken();

  DetailViewModel({
    required this.work,
  }) {
    _audioService = GetIt.I<IAudioPlayerService>();
    _apiService = GetIt.I<ApiService>();
    _downloadDirectoryController = GetIt.I<DownloadDirectoryController>();
    _downloadProgressManager = GetIt.I<DownloadProgressManager>();
    _authRepository = GetIt.I<AuthRepository>();
    _fileDownloader = FileDownloader();
    _currentRating = _normalizeRating(work.userRating);
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

  Future<void> updateRating(int rating) async {
    _loadingRating = true;
    notifyListeners();

    try {
      await _apiService.updateWorkRating(work.id.toString(), rating);
      _currentRating = rating;
      AppLogger.info('更新评分成功: $rating');
    } catch (e) {
      AppLogger.error('更新评分失败', e);
      rethrow;
    } finally {
      _loadingRating = false;
      notifyListeners();
    }
  }

  Future<DownloadBatchResult> downloadFiles(
    List<DownloadRequestItem> files,
  ) async {
    _downloadingFiles = true;
    notifyListeners();

    var successCount = 0;
    var failedCount = 0;
    var saveDirectoryPath = '';

    try {
      await _fileDownloader.ready;
      final rootDirectory =
          await _downloadDirectoryController.resolveDownloadRootDirectory();
      final saveDirectory = await _resolveWorkDirectory(rootDirectory);
      saveDirectoryPath = saveDirectory.path;
      final downloadHeaders = await _buildDownloadHeaders();

      for (final requestItem in files) {
        final file = requestItem.file;
        final downloadUrl = file.mediaDownloadUrl;
        if (downloadUrl == null || downloadUrl.isEmpty) {
          failedCount++;
          continue;
        }

        final targetDirectory = await _resolveTargetDirectory(
          saveDirectory,
          requestItem.relativeDirectories,
        );
        final safeFileName = _sanitizeFileName(file.title);
        final savePath =
            await _createUniqueSavePath(targetDirectory, safeFileName);
        final taskId = _downloadProgressManager.createTask(
          workId: work.id,
          workTitle: _resolveWorkTitle(),
          fileName: safeFileName,
          savePath: savePath,
        );

        try {
          _downloadProgressManager.markStarted(taskId);
          final expectedBytes = (file.size ?? 0) > 0 ? file.size! : 0;
          final statusUpdate = await _fileDownloader.download(
            DownloadTask(
              taskId: taskId,
              url: downloadUrl,
              filename: _fileNameFromPath(savePath),
              directory: targetDirectory.path,
              baseDirectory: BaseDirectory.root,
              headers: downloadHeaders,
              updates: Updates.statusAndProgress,
            ),
            onProgress: (progress) {
              if (expectedBytes > 0) {
                final receivedBytes =
                    (expectedBytes * progress.clamp(0.0, 1.0)).round();
                _downloadProgressManager.updateProgress(
                  taskId,
                  receivedBytes,
                  expectedBytes,
                );
                return;
              }
              _downloadProgressManager.updateProgress(taskId, 0, 0);
            },
          );

          if (statusUpdate.status == TaskStatus.complete) {
            _downloadProgressManager.markCompleted(taskId);
            successCount++;
            continue;
          }

          final errorMessage = statusUpdate.exception?.description ??
              '下载状态异常: ${statusUpdate.status.name}';
          _downloadProgressManager.markFailed(taskId, errorMessage);
          failedCount++;
          AppLogger.error('下载文件失败: ${file.title}', errorMessage);
        } catch (e) {
          _downloadProgressManager.markFailed(taskId, e);
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

  Future<Map<String, String>> _buildDownloadHeaders() async {
    final authData = await _authRepository.getAuthData();
    final token = authData?.token?.trim();
    if (token == null || token.isEmpty) {
      return const <String, String>{};
    }
    return <String, String>{'Authorization': 'Bearer $token'};
  }

  Future<Directory> _resolveWorkDirectory(Directory rootDirectory) async {
    final workFolderName = _sanitizeFileName(
      (work.sourceId?.trim().isNotEmpty ?? false)
          ? work.sourceId!
          : 'work_${work.id ?? 'unknown'}',
    );

    final workDirectory = Directory(
      '${rootDirectory.path}${Platform.pathSeparator}$workFolderName',
    );
    if (!await workDirectory.exists()) {
      await workDirectory.create(recursive: true);
    }
    return workDirectory;
  }

  Future<Directory> _resolveTargetDirectory(
    Directory workDirectory,
    List<String> relativeDirectories,
  ) async {
    if (relativeDirectories.isEmpty) {
      return workDirectory;
    }

    final safeSegments = relativeDirectories
        .map((segment) => _sanitizePathSegment(segment, fallback: 'folder'))
        .where((segment) => segment.isNotEmpty)
        .toList(growable: false);
    if (safeSegments.isEmpty) {
      return workDirectory;
    }

    var targetPath = workDirectory.path;
    for (final segment in safeSegments) {
      targetPath = '$targetPath${Platform.pathSeparator}$segment';
    }
    final targetDirectory = Directory(targetPath);
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }
    return targetDirectory;
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
    return _sanitizePathSegment(original, fallback: 'file');
  }

  String _fileNameFromPath(String fullPath) {
    final segments = fullPath.split(RegExp(r'[\\/]'));
    if (segments.isEmpty || segments.last.isEmpty) {
      return 'file';
    }
    return segments.last;
  }

  String _sanitizePathSegment(
    String? original, {
    required String fallback,
  }) {
    final normalized = (original ?? '').trim();
    if (normalized.isEmpty) {
      return fallback;
    }
    final sanitized = normalized.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
    if (sanitized == '.' || sanitized == '..') {
      return fallback;
    }
    return sanitized;
  }

  String _resolveWorkTitle() {
    final sourceId = work.sourceId?.trim();
    if (sourceId != null && sourceId.isNotEmpty) {
      return sourceId;
    }
    final title = work.title?.trim();
    if (title != null && title.isNotEmpty) {
      return title;
    }
    return 'work_${work.id ?? 'unknown'}';
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

  Future<void> showRatingDialog(BuildContext context) async {
    var selectedRating = _currentRating ?? 0;
    final rating = await showDialog<int>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (builderContext, setState) => AlertDialog(
          title: Text(builderContext.l10n.workActionRate),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              final value = index + 1;
              return IconButton(
                onPressed: _loadingRating
                    ? null
                    : () => setState(() {
                          selectedRating = value;
                        }),
                icon: Icon(
                  value <= selectedRating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              );
            }),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(builderContext.l10n.cancel),
            ),
            TextButton(
              onPressed: selectedRating == 0 || _loadingRating
                  ? null
                  : () => Navigator.of(dialogContext).pop(selectedRating),
              child: Text(builderContext.l10n.confirm),
            ),
          ],
        ),
      ),
    );

    if (rating == null) return;

    try {
      await updateRating(rating);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${context.l10n.workActionRate}: $rating/5')),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.operationFailed(e.toString()))),
      );
    }
  }

  int? _normalizeRating(dynamic rating) {
    final parsed = switch (rating) {
      int value => value,
      double value => value.round(),
      String value => int.tryParse(value) ?? double.tryParse(value)?.round(),
      _ => null,
    };
    if (parsed == null) return null;
    return parsed.clamp(1, 5);
  }

  @override
  void dispose() {
    // 取消所有正在进行的请求
    _cancelToken.cancel('ViewModel disposed');
    _disposed = true;
    super.dispose();
  }
}
