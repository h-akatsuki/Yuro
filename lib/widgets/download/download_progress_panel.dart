import 'package:asmrapp/core/download/download_progress_manager.dart';
import 'package:asmrapp/core/download/download_task.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/utils/file_size_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DownloadProgressPanel extends StatelessWidget {
  const DownloadProgressPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DownloadProgressManager>(
      builder: (context, manager, _) {
        final activeTasks = manager.activeTasks;
        final finishedTasks = manager.finishedTasks;

        if (activeTasks.isEmpty && finishedTasks.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                context.l10n.downloadProgressEmpty,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return Column(
          children: [
            if (finishedTasks.isNotEmpty)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: TextButton.icon(
                    onPressed: manager.clearFinished,
                    icon: const Icon(Icons.cleaning_services_outlined),
                    label: Text(context.l10n.downloadProgressClearFinished),
                  ),
                ),
              ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 20),
                children: [
                  if (activeTasks.isNotEmpty) ...[
                    _ProgressSectionTitle(
                      title: context.l10n.downloadProgressActiveSection,
                    ),
                    ...activeTasks.map((task) => _TaskCard(task: task)),
                    const SizedBox(height: 12),
                  ],
                  if (finishedTasks.isNotEmpty) ...[
                    _ProgressSectionTitle(
                      title: context.l10n.downloadProgressHistorySection,
                    ),
                    ...finishedTasks.map((task) => _TaskCard(task: task)),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ProgressSectionTitle extends StatelessWidget {
  final String title;

  const _ProgressSectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final DownloadTask task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(context, task.status);
    final statusIcon = _statusIcon(task.status);
    final canShowKnownProgress =
        task.totalBytes > 0 && task.status == DownloadTaskStatus.running;
    final showIndeterminate =
        task.totalBytes <= 0 && task.status == DownloadTaskStatus.running;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              margin: const EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(
                statusIcon,
                size: 16,
                color: statusColor,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.fileName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    task.workTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: showIndeterminate ? null : task.progress,
                    minHeight: 4,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _buildProgressText(context, task, canShowKnownProgress),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (task.status == DownloadTaskStatus.failed &&
                      task.errorMessage != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      task.errorMessage!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildProgressText(
    BuildContext context,
    DownloadTask task,
    bool canShowKnownProgress,
  ) {
    switch (task.status) {
      case DownloadTaskStatus.queued:
        return context.l10n.downloadStatusQueued;
      case DownloadTaskStatus.running:
        if (canShowKnownProgress) {
          final percent = (task.progress * 100).toStringAsFixed(0);
          return '$percent% · ${FileSizeFormatter.format(task.receivedBytes)} / '
              '${FileSizeFormatter.format(task.totalBytes)}';
        }
        return context.l10n.downloadStatusRunning;
      case DownloadTaskStatus.completed:
        return context.l10n.downloadStatusCompleted;
      case DownloadTaskStatus.failed:
        return context.l10n.downloadStatusFailed;
    }
  }

  IconData _statusIcon(DownloadTaskStatus status) {
    switch (status) {
      case DownloadTaskStatus.queued:
        return Icons.schedule;
      case DownloadTaskStatus.running:
        return Icons.downloading_rounded;
      case DownloadTaskStatus.completed:
        return Icons.check_circle_rounded;
      case DownloadTaskStatus.failed:
        return Icons.error_rounded;
    }
  }

  Color _statusColor(BuildContext context, DownloadTaskStatus status) {
    switch (status) {
      case DownloadTaskStatus.queued:
        return Theme.of(context).colorScheme.primary;
      case DownloadTaskStatus.running:
        return Theme.of(context).colorScheme.primary;
      case DownloadTaskStatus.completed:
        return Colors.green.shade600;
      case DownloadTaskStatus.failed:
        return Theme.of(context).colorScheme.error;
    }
  }
}
