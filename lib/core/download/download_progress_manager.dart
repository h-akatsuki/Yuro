import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:asmrapp/core/download/download_task.dart';
import 'package:background_downloader/background_downloader.dart' as bg;
import 'package:flutter/foundation.dart';

class DownloadQueueRequest {
  final int? workId;
  final String workTitle;
  final String fileName;
  final String savePath;
  final String url;
  final Map<String, String> headers;
  final int expectedBytes;
  final String? sharedDirectory;

  const DownloadQueueRequest({
    required this.workId,
    required this.workTitle,
    required this.fileName,
    required this.savePath,
    required this.url,
    required this.headers,
    required this.expectedBytes,
    this.sharedDirectory,
  });
}

class DownloadProgressManager extends ChangeNotifier {
  static const int _maxHistory = 200;
  static const String _downloadGroup = 'yuro_downloads';

  final List<DownloadTask> _tasks = [];
  final Map<String, bg.DownloadTask> _backgroundTasks = {};
  final Set<String> _publishingTasks = <String>{};
  final bg.FileDownloader _downloader;
  late final StreamSubscription<bg.TaskUpdate> _updatesSubscription;
  late final Future<void> _initialization;
  int _sequence = 0;

  DownloadProgressManager({bg.FileDownloader? downloader})
    : _downloader = downloader ?? bg.FileDownloader() {
    _updatesSubscription = _downloader.updates.listen(
      _handleUpdate,
      onError: (Object error, StackTrace stackTrace) {
        debugPrint('Download update stream failed: $error');
      },
    );
    _initialization = _initialize();
  }

  Future<void> get ready => _initialization;

  UnmodifiableListView<DownloadTask> get tasks => UnmodifiableListView(_tasks);

  List<DownloadTask> get activeTasks =>
      _tasks.where((task) => task.isActive).toList(growable: false);

  List<DownloadTask> get finishedTasks =>
      _tasks.where((task) => task.isFinished).toList(growable: false);

  bool get hasActiveTasks => _tasks.any((task) => task.isActive);

  Set<String> get reservedSavePaths => _tasks
      .where((task) => task.isActive)
      .map((task) => task.savePath)
      .toSet();

  double? get activeProgress {
    final active = activeTasks;
    if (active.isEmpty) return null;

    final knownTasks = active.where((task) => task.totalBytes > 0).toList();
    if (knownTasks.isEmpty) return null;
    final totalBytes = knownTasks.fold<int>(
      0,
      (sum, task) => sum + task.totalBytes,
    );
    if (totalBytes <= 0) return null;
    final receivedBytes = knownTasks.fold<int>(
      0,
      (sum, task) => sum + task.receivedBytes.clamp(0, task.totalBytes),
    );
    return (receivedBytes / totalBytes).clamp(0, 1);
  }

  Future<List<bool>> enqueueAll(List<DownloadQueueRequest> requests) async {
    if (requests.isEmpty) return const <bool>[];
    await ready;

    final nativeTasks = <bg.DownloadTask>[];
    for (final request in requests) {
      final taskId = _createTaskId();
      final (baseDirectory, directory, filename) = await bg.Task.split(
        filePath: request.savePath,
      );
      final metadata = jsonEncode(<String, Object?>{
        'version': 1,
        'workId': request.workId,
        'workTitle': request.workTitle,
        'fileName': request.fileName,
        'savePath': request.savePath,
        'expectedBytes': request.expectedBytes,
        'sharedDirectory': request.sharedDirectory,
      });
      final nativeTask = bg.DownloadTask(
        taskId: taskId,
        url: request.url,
        filename: filename,
        directory: directory,
        baseDirectory: baseDirectory,
        group: _downloadGroup,
        headers: request.headers,
        updates: bg.Updates.statusAndProgress,
        retries: 2,
        allowPause: true,
        metaData: metadata,
        displayName: request.fileName,
      );

      nativeTasks.add(nativeTask);
      _backgroundTasks[taskId] = nativeTask;
      _tasks.insert(
        0,
        DownloadTask(
          id: taskId,
          workId: request.workId,
          workTitle: request.workTitle,
          fileName: request.fileName,
          savePath: request.savePath,
          receivedBytes: 0,
          totalBytes: request.expectedBytes,
          status: DownloadTaskStatus.queued,
          createdAt: nativeTask.creationTime,
        ),
      );
    }
    _trimHistory();
    notifyListeners();

    try {
      final results = await _downloader.enqueueAll(nativeTasks);
      for (var index = 0; index < nativeTasks.length; index++) {
        final enqueued = index < results.length && results[index];
        if (!enqueued) {
          _markFailed(
            nativeTasks[index].taskId,
            'The download could not be added to the queue.',
          );
        }
      }
      return <bool>[
        for (var index = 0; index < nativeTasks.length; index++)
          index < results.length && results[index],
      ];
    } catch (error) {
      for (final task in nativeTasks) {
        _markFailed(task.taskId, error);
      }
      return List<bool>.filled(nativeTasks.length, false);
    }
  }

  Future<bool> cancelTask(String taskId) async {
    await ready;
    final canceled = await _downloader.cancelTaskWithId(taskId);
    if (canceled) {
      _updateTask(
        taskId,
        (task) => task.copyWith(
          status: DownloadTaskStatus.canceled,
          finishedAt: DateTime.now(),
          clearTimeRemaining: true,
        ),
      );
    }
    return canceled;
  }

  Future<bool> pauseTask(String taskId) async {
    await ready;
    final nativeTask = await _downloadTaskForId(taskId);
    if (nativeTask == null) return false;
    final paused = await _downloader.pause(nativeTask);
    if (paused) {
      _updateTask(
        taskId,
        (task) => task.copyWith(status: DownloadTaskStatus.paused),
      );
    }
    return paused;
  }

  Future<bool> resumeTask(String taskId) async {
    await ready;
    final nativeTask = await _downloadTaskForId(taskId);
    if (nativeTask == null) return false;
    final resumed = await _downloader.resume(nativeTask);
    if (resumed) {
      _updateTask(
        taskId,
        (task) => task.copyWith(
          status: DownloadTaskStatus.queued,
          clearError: true,
          clearFinishedAt: true,
        ),
      );
    }
    return resumed;
  }

  Future<bool> retryTask(String taskId) async {
    await ready;
    final nativeTask = await _downloadTaskForId(taskId);
    if (nativeTask == null) return false;

    final retryTask = nativeTask.copyWith(
      creationTime: DateTime.now(),
      retriesRemaining: nativeTask.retries,
    );
    _backgroundTasks[taskId] = retryTask;
    _updateTask(
      taskId,
      (task) => task.copyWith(
        status: DownloadTaskStatus.queued,
        receivedBytes: 0,
        clearError: true,
        clearFinishedAt: true,
        clearTimeRemaining: true,
        networkSpeed: 0,
      ),
    );

    final enqueued = await _downloader.enqueue(retryTask);
    if (!enqueued) {
      _markFailed(taskId, 'The download could not be added to the queue.');
    }
    return enqueued;
  }

  void clearFinished() {
    final finishedIds = _tasks
        .where((task) => task.isFinished)
        .map((task) => task.id)
        .toList(growable: false);
    if (finishedIds.isEmpty) return;

    _tasks.removeWhere((task) => task.isFinished);
    for (final taskId in finishedIds) {
      _backgroundTasks.remove(taskId);
    }
    notifyListeners();
    unawaited(_downloader.database.deleteRecordsWithIds(finishedIds));
  }

  Future<void> _initialize() async {
    await _downloader.ready;
    await _downloader.start(autoCleanDatabase: true);
    final records = await _downloader.database.allRecords(
      group: _downloadGroup,
    );
    for (final record in records) {
      _restoreRecord(record);
    }
    _tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _trimHistory();
    notifyListeners();
  }

  void _handleUpdate(bg.TaskUpdate update) {
    final nativeTask = update.task;
    if (nativeTask.group != _downloadGroup || nativeTask is! bg.DownloadTask) {
      return;
    }
    _backgroundTasks[nativeTask.taskId] = nativeTask;

    switch (update) {
      case bg.TaskStatusUpdate():
        unawaited(_applyStatusUpdate(update));
      case bg.TaskProgressUpdate():
        _applyProgressUpdate(update);
    }
  }

  Future<void> _applyStatusUpdate(bg.TaskStatusUpdate update) async {
    final task = _ensureLocalTask(update.task);
    if (update.status == bg.TaskStatus.complete) {
      final metadata = _metadataFor(update.task);
      if (metadata.sharedDirectory != null &&
          _publishingTasks.add(update.task.taskId)) {
        try {
          final publishedPath = await _publishToSharedDownloads(
            update.task as bg.DownloadTask,
            metadata.sharedDirectory!,
          );
          _replaceTask(
            task.id,
            task.copyWith(
              status: DownloadTaskStatus.completed,
              receivedBytes: task.totalBytes > 0
                  ? task.totalBytes
                  : task.receivedBytes,
              savePath: publishedPath,
              finishedAt: DateTime.now(),
              clearError: true,
              clearTimeRemaining: true,
              networkSpeed: 0,
            ),
          );
        } catch (error) {
          _markFailed(task.id, error);
        } finally {
          _publishingTasks.remove(update.task.taskId);
        }
        return;
      }
      if (_publishingTasks.contains(update.task.taskId)) return;
    }
    final status = _statusFromBackground(update.status);
    final now = DateTime.now();
    final error =
        update.exception?.description ??
        (update.status == bg.TaskStatus.notFound
            ? 'The requested file was not found.'
            : null);
    _replaceTask(
      task.id,
      task.copyWith(
        status: status,
        startedAt: update.status == bg.TaskStatus.running
            ? (task.startedAt ?? now)
            : null,
        finishedAt: update.status.isFinalState ? now : null,
        clearFinishedAt: !update.status.isFinalState,
        errorMessage: error,
        clearError: error == null,
        clearTimeRemaining: update.status != bg.TaskStatus.running,
        networkSpeed: update.status == bg.TaskStatus.running
            ? task.networkSpeed
            : 0,
      ),
    );
  }

  void _applyProgressUpdate(bg.TaskProgressUpdate update) {
    if (update.progress < 0) return;
    final task = _ensureLocalTask(update.task);
    if (task.isFinished) return;
    final totalBytes = update.hasExpectedFileSize && update.expectedFileSize > 0
        ? update.expectedFileSize
        : task.totalBytes;
    final receivedBytes = totalBytes > 0
        ? (totalBytes * update.progress.clamp(0.0, 1.0)).round()
        : task.receivedBytes;
    _replaceTask(
      task.id,
      task.copyWith(
        status: DownloadTaskStatus.running,
        receivedBytes: receivedBytes,
        totalBytes: totalBytes,
        startedAt: task.startedAt ?? DateTime.now(),
        clearFinishedAt: true,
        networkSpeed: update.hasNetworkSpeed ? update.networkSpeed : 0,
        timeRemaining: update.hasTimeRemaining ? update.timeRemaining : null,
        clearTimeRemaining: !update.hasTimeRemaining || update.progress >= 1,
        clearError: true,
      ),
    );
  }

  void _restoreRecord(bg.TaskRecord record) {
    if (record.task is! bg.DownloadTask) return;
    final nativeTask = record.task as bg.DownloadTask;
    _backgroundTasks[nativeTask.taskId] = nativeTask;
    final task = _localTaskFromBackground(nativeTask).copyWith(
      status: _statusFromBackground(record.status),
      totalBytes: record.expectedFileSize > 0
          ? record.expectedFileSize
          : _metadataFor(nativeTask).expectedBytes,
      receivedBytes: _receivedBytesForRecord(record, nativeTask),
      errorMessage: record.exception?.description,
      finishedAt: record.status.isFinalState ? nativeTask.creationTime : null,
    );
    final index = _tasks.indexWhere((item) => item.id == task.id);
    if (index < 0) {
      _tasks.add(task);
    } else {
      _tasks[index] = task;
    }
    final metadata = _metadataFor(nativeTask);
    if (record.status == bg.TaskStatus.complete &&
        metadata.sharedDirectory != null) {
      unawaited(_ensurePublishedAfterRestore(nativeTask, metadata));
    }
  }

  int _receivedBytesForRecord(bg.TaskRecord record, bg.DownloadTask task) {
    final metadata = _metadataFor(task);
    final total = record.expectedFileSize > 0
        ? record.expectedFileSize
        : metadata.expectedBytes;
    if (total <= 0 || record.progress < 0) return 0;
    return (total * record.progress.clamp(0.0, 1.0)).round();
  }

  DownloadTask _ensureLocalTask(bg.Task nativeTask) {
    final index = _tasks.indexWhere((task) => task.id == nativeTask.taskId);
    if (index >= 0) return _tasks[index];
    final task = _localTaskFromBackground(nativeTask);
    _tasks.insert(0, task);
    _trimHistory();
    return task;
  }

  DownloadTask _localTaskFromBackground(bg.Task nativeTask) {
    final metadata = _metadataFor(nativeTask);
    return DownloadTask(
      id: nativeTask.taskId,
      workId: metadata.workId,
      workTitle: metadata.workTitle,
      fileName: metadata.fileName,
      savePath: metadata.savePath.isNotEmpty
          ? metadata.savePath
          : _fallbackSavePath(nativeTask),
      receivedBytes: 0,
      totalBytes: metadata.expectedBytes,
      status: DownloadTaskStatus.queued,
      createdAt: nativeTask.creationTime,
    );
  }

  _DownloadMetadata _metadataFor(bg.Task task) {
    try {
      final json = jsonDecode(task.metaData);
      if (json is Map<String, dynamic>) {
        return _DownloadMetadata(
          workId: (json['workId'] as num?)?.toInt(),
          workTitle: json['workTitle'] as String? ?? '',
          fileName: json['fileName'] as String? ?? task.displayName,
          savePath: json['savePath'] as String? ?? '',
          expectedBytes: (json['expectedBytes'] as num?)?.toInt() ?? 0,
          sharedDirectory: json['sharedDirectory'] as String?,
        );
      }
    } catch (_) {
      // Older tasks may not contain structured metadata.
    }
    return _DownloadMetadata(
      workId: null,
      workTitle: '',
      fileName: task.displayName.isNotEmpty ? task.displayName : task.filename,
      savePath: _fallbackSavePath(task),
      expectedBytes: 0,
      sharedDirectory: null,
    );
  }

  String _fallbackSavePath(bg.Task task) {
    if (task.directory.isEmpty) return task.filename;
    return '${task.directory}${Platform.pathSeparator}${task.filename}';
  }

  Future<String> _publishToSharedDownloads(
    bg.DownloadTask task,
    String sharedDirectory,
  ) async {
    final sourcePath = await task.filePath();
    if (!await File(sourcePath).exists()) {
      return 'Downloads/$sharedDirectory/${task.filename}';
    }
    final publishedPath = await _downloader.moveToSharedStorage(
      task,
      bg.SharedStorage.downloads,
      directory: sharedDirectory,
    );
    if (publishedPath == null || publishedPath.isEmpty) {
      throw Exception('共有ダウンロードフォルダへの保存に失敗しました');
    }
    return publishedPath;
  }

  Future<void> _ensurePublishedAfterRestore(
    bg.DownloadTask task,
    _DownloadMetadata metadata,
  ) async {
    if (!_publishingTasks.add(task.taskId)) return;
    try {
      final publishedPath = await _publishToSharedDownloads(
        task,
        metadata.sharedDirectory!,
      );
      _updateTask(
        task.taskId,
        (localTask) => localTask.copyWith(
          savePath: publishedPath,
          status: DownloadTaskStatus.completed,
          clearError: true,
        ),
      );
    } catch (error) {
      _markFailed(task.taskId, error);
    } finally {
      _publishingTasks.remove(task.taskId);
    }
  }

  DownloadTaskStatus _statusFromBackground(bg.TaskStatus status) {
    return switch (status) {
      bg.TaskStatus.enqueued => DownloadTaskStatus.queued,
      bg.TaskStatus.running => DownloadTaskStatus.running,
      bg.TaskStatus.waitingToRetry => DownloadTaskStatus.waitingToRetry,
      bg.TaskStatus.paused => DownloadTaskStatus.paused,
      bg.TaskStatus.complete => DownloadTaskStatus.completed,
      bg.TaskStatus.canceled => DownloadTaskStatus.canceled,
      bg.TaskStatus.notFound ||
      bg.TaskStatus.failed => DownloadTaskStatus.failed,
    };
  }

  Future<bg.DownloadTask?> _downloadTaskForId(String taskId) async {
    final cached = _backgroundTasks[taskId];
    if (cached != null) return cached;
    final activeTask = await _downloader.taskForId(taskId);
    if (activeTask is bg.DownloadTask) {
      _backgroundTasks[taskId] = activeTask;
      return activeTask;
    }
    final record = await _downloader.database.recordForId(taskId);
    if (record?.task case final bg.DownloadTask task) {
      _backgroundTasks[taskId] = task;
      return task;
    }
    return null;
  }

  String _createTaskId() {
    _sequence++;
    return '${DateTime.now().microsecondsSinceEpoch}_$_sequence';
  }

  void _markFailed(String taskId, Object error) {
    _updateTask(
      taskId,
      (task) => task.copyWith(
        status: DownloadTaskStatus.failed,
        finishedAt: DateTime.now(),
        errorMessage: error.toString(),
        clearTimeRemaining: true,
        networkSpeed: 0,
      ),
    );
  }

  void _updateTask(
    String taskId,
    DownloadTask Function(DownloadTask task) map,
  ) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index < 0) return;
    _tasks[index] = map(_tasks[index]);
    notifyListeners();
  }

  void _replaceTask(String taskId, DownloadTask task) {
    final index = _tasks.indexWhere((item) => item.id == taskId);
    if (index < 0) {
      _tasks.insert(0, task);
      _trimHistory();
    } else {
      _tasks[index] = task;
    }
    notifyListeners();
  }

  void _trimHistory() {
    if (_tasks.length <= _maxHistory) return;
    final active = _tasks.where((task) => task.isActive).toList();
    final finished = _tasks.where((task) => task.isFinished).toList();
    final remainingHistorySlots = (_maxHistory - active.length).clamp(
      0,
      _maxHistory,
    );
    _tasks
      ..clear()
      ..addAll(active)
      ..addAll(finished.take(remainingHistorySlots));
  }

  @override
  void dispose() {
    unawaited(_updatesSubscription.cancel());
    super.dispose();
  }
}

class _DownloadMetadata {
  final int? workId;
  final String workTitle;
  final String fileName;
  final String savePath;
  final int expectedBytes;
  final String? sharedDirectory;

  const _DownloadMetadata({
    required this.workId,
    required this.workTitle,
    required this.fileName,
    required this.savePath,
    required this.expectedBytes,
    required this.sharedDirectory,
  });
}
