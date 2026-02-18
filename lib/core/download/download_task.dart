enum DownloadTaskStatus {
  queued,
  running,
  completed,
  failed,
}

class DownloadTask {
  final String id;
  final int? workId;
  final String workTitle;
  final String fileName;
  final String savePath;
  final int receivedBytes;
  final int totalBytes;
  final DownloadTaskStatus status;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final String? errorMessage;

  const DownloadTask({
    required this.id,
    required this.workId,
    required this.workTitle,
    required this.fileName,
    required this.savePath,
    required this.receivedBytes,
    required this.totalBytes,
    required this.status,
    required this.createdAt,
    this.startedAt,
    this.finishedAt,
    this.errorMessage,
  });

  double get progress {
    if (status == DownloadTaskStatus.completed) {
      return 1;
    }
    if (totalBytes <= 0) {
      return 0;
    }
    final value = receivedBytes / totalBytes;
    if (value.isNaN || value.isInfinite) {
      return 0;
    }
    return value.clamp(0, 1);
  }

  bool get isActive =>
      status == DownloadTaskStatus.queued ||
      status == DownloadTaskStatus.running;

  bool get isFinished =>
      status == DownloadTaskStatus.completed ||
      status == DownloadTaskStatus.failed;

  DownloadTask copyWith({
    int? receivedBytes,
    int? totalBytes,
    DownloadTaskStatus? status,
    DateTime? startedAt,
    DateTime? finishedAt,
    String? errorMessage,
    bool clearError = false,
  }) {
    return DownloadTask(
      id: id,
      workId: workId,
      workTitle: workTitle,
      fileName: fileName,
      savePath: savePath,
      receivedBytes: receivedBytes ?? this.receivedBytes,
      totalBytes: totalBytes ?? this.totalBytes,
      status: status ?? this.status,
      createdAt: createdAt,
      startedAt: startedAt ?? this.startedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
