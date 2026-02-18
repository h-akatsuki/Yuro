import 'dart:collection';

import 'package:asmrapp/core/download/download_task.dart';
import 'package:flutter/foundation.dart';

class DownloadProgressManager extends ChangeNotifier {
  static const int _maxHistory = 200;

  final List<DownloadTask> _tasks = [];
  int _sequence = 0;

  UnmodifiableListView<DownloadTask> get tasks => UnmodifiableListView(_tasks);

  List<DownloadTask> get activeTasks =>
      _tasks.where((task) => task.isActive).toList(growable: false);

  List<DownloadTask> get finishedTasks =>
      _tasks.where((task) => task.isFinished).toList(growable: false);

  bool get hasActiveTasks => _tasks.any((task) => task.isActive);

  String createTask({
    required int? workId,
    required String workTitle,
    required String fileName,
    required String savePath,
  }) {
    _sequence++;
    final id = '${DateTime.now().microsecondsSinceEpoch}_$_sequence';
    _tasks.insert(
      0,
      DownloadTask(
        id: id,
        workId: workId,
        workTitle: workTitle,
        fileName: fileName,
        savePath: savePath,
        receivedBytes: 0,
        totalBytes: 0,
        status: DownloadTaskStatus.queued,
        createdAt: DateTime.now(),
      ),
    );
    _trimHistory();
    notifyListeners();
    return id;
  }

  void markStarted(String taskId) {
    _updateTask(
      taskId,
      (task) => task.copyWith(
        status: DownloadTaskStatus.running,
        startedAt: DateTime.now(),
        clearError: true,
      ),
    );
  }

  void updateProgress(String taskId, int receivedBytes, int totalBytes) {
    _updateTask(
      taskId,
      (task) => task.copyWith(
        status: DownloadTaskStatus.running,
        receivedBytes: receivedBytes < 0 ? 0 : receivedBytes,
        totalBytes: totalBytes < 0 ? 0 : totalBytes,
      ),
    );
  }

  void markCompleted(String taskId) {
    _updateTask(
      taskId,
      (task) => task.copyWith(
        status: DownloadTaskStatus.completed,
        receivedBytes:
            task.totalBytes > 0 ? task.totalBytes : task.receivedBytes,
        finishedAt: DateTime.now(),
      ),
    );
  }

  void markFailed(String taskId, Object error) {
    _updateTask(
      taskId,
      (task) => task.copyWith(
        status: DownloadTaskStatus.failed,
        finishedAt: DateTime.now(),
        errorMessage: error.toString(),
      ),
    );
  }

  void clearFinished() {
    _tasks.removeWhere((task) => task.isFinished);
    notifyListeners();
  }

  void _updateTask(
      String taskId, DownloadTask Function(DownloadTask task) map) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index < 0) {
      return;
    }
    _tasks[index] = map(_tasks[index]);
    notifyListeners();
  }

  void _trimHistory() {
    if (_tasks.length <= _maxHistory) {
      return;
    }
    _tasks.removeRange(_maxHistory, _tasks.length);
  }
}
