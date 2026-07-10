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
          return _EmptyDownloads();
        }

        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            if (activeTasks.isNotEmpty) ...[
              _ActiveSummary(
                count: activeTasks.length,
                progress: manager.activeProgress,
              ),
              const SizedBox(height: 22),
              _SectionHeader(
                title: context.l10n.downloadProgressActiveSection,
                count: activeTasks.length,
              ),
              const SizedBox(height: 8),
              _TaskGroup(tasks: activeTasks, manager: manager),
            ],
            if (activeTasks.isNotEmpty && finishedTasks.isNotEmpty)
              const SizedBox(height: 24),
            if (finishedTasks.isNotEmpty) ...[
              _SectionHeader(
                title: context.l10n.downloadProgressHistorySection,
                count: finishedTasks.length,
                trailing: TextButton.icon(
                  onPressed: manager.clearFinished,
                  icon: const Icon(Icons.delete_sweep_outlined, size: 19),
                  label: Text(context.l10n.downloadProgressClearFinished),
                ),
              ),
              const SizedBox(height: 8),
              _TaskGroup(tasks: finishedTasks, manager: manager),
            ],
          ],
        );
      },
    );
  }
}

class _EmptyDownloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.download_for_offline_outlined,
                size: 38,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.downloadProgressEmpty,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                context.l10n.downloadProgressEmptyDescription,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveSummary extends StatelessWidget {
  final int count;
  final double? progress;

  const _ActiveSummary({required this.count, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final percent = progress == null ? null : (progress! * 100).round();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withValues(alpha: 0.52),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.downloading_rounded,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.downloadActiveCount(count),
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    ),
                    if (percent != null)
                      Text(
                        '$percent%',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 9),
                LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(999),
                  color: colorScheme.primary,
                  backgroundColor: colorScheme.onPrimaryContainer.withValues(
                    alpha: 0.13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Widget? trailing;

  const _SectionHeader({
    required this.title,
    required this.count,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text('$count', style: Theme.of(context).textTheme.labelMedium),
        ),
        const Spacer(),
        ?trailing,
      ],
    );
  }
}

class _TaskGroup extends StatelessWidget {
  final List<DownloadTask> tasks;
  final DownloadProgressManager manager;

  const _TaskGroup({required this.tasks, required this.manager});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.28),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          for (var index = 0; index < tasks.length; index++) ...[
            if (index > 0)
              Divider(
                height: 1,
                indent: 64,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            _TaskTile(task: tasks[index], manager: manager),
          ],
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final DownloadTask task;
  final DownloadProgressManager manager;

  const _TaskTile({required this.task, required this.manager});

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(context, task.status);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 13, 8, 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Icon(_statusIcon(task.status), size: 20, color: statusColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.fileName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _StatusPill(
                      label: _statusLabel(context, task.status),
                      color: statusColor,
                    ),
                  ],
                ),
                if (task.workTitle.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    task.workTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (task.isActive) ...[
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _progressValue(task),
                    minHeight: 5,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ],
                const SizedBox(height: 7),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _buildDetailText(context, task),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: task.status == DownloadTaskStatus.failed
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    ..._buildActions(context),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double? _progressValue(DownloadTask task) {
    if (task.status == DownloadTaskStatus.running && task.totalBytes <= 0) {
      return null;
    }
    return task.progress;
  }

  List<Widget> _buildActions(BuildContext context) {
    final actions = <Widget>[];
    switch (task.status) {
      case DownloadTaskStatus.running:
        actions.add(
          _ActionButton(
            tooltip: context.l10n.downloadPause,
            icon: Icons.pause_rounded,
            onPressed: () => manager.pauseTask(task.id),
          ),
        );
        actions.add(_cancelButton(context));
      case DownloadTaskStatus.queued:
      case DownloadTaskStatus.waitingToRetry:
        actions.add(_cancelButton(context));
      case DownloadTaskStatus.paused:
        actions.add(
          _ActionButton(
            tooltip: context.l10n.downloadResume,
            icon: Icons.play_arrow_rounded,
            onPressed: () => manager.resumeTask(task.id),
          ),
        );
        actions.add(_cancelButton(context));
      case DownloadTaskStatus.failed:
      case DownloadTaskStatus.canceled:
        actions.add(
          _ActionButton(
            tooltip: context.l10n.downloadRetry,
            icon: Icons.refresh_rounded,
            onPressed: () => manager.retryTask(task.id),
          ),
        );
      case DownloadTaskStatus.completed:
        break;
    }
    return actions;
  }

  Widget _cancelButton(BuildContext context) {
    return _ActionButton(
      tooltip: context.l10n.downloadCancelTask,
      icon: Icons.close_rounded,
      onPressed: () => manager.cancelTask(task.id),
    );
  }

  String _buildDetailText(BuildContext context, DownloadTask task) {
    switch (task.status) {
      case DownloadTaskStatus.running:
        final details = <String>[];
        if (task.totalBytes > 0) {
          details.add('${(task.progress * 100).round()}%');
          details.add(
            '${FileSizeFormatter.format(task.receivedBytes)} / '
            '${FileSizeFormatter.format(task.totalBytes)}',
          );
        }
        if (task.networkSpeed > 0) {
          details.add('${task.networkSpeed.toStringAsFixed(1)} MB/s');
        }
        if (task.timeRemaining != null && task.timeRemaining! > Duration.zero) {
          details.add(_durationLabel(task.timeRemaining!));
        }
        return details.isEmpty
            ? context.l10n.downloadStatusRunning
            : details.join(' · ');
      case DownloadTaskStatus.queued:
        return context.l10n.downloadStatusQueued;
      case DownloadTaskStatus.waitingToRetry:
        return context.l10n.downloadStatusWaitingToRetry;
      case DownloadTaskStatus.paused:
        if (task.totalBytes <= 0) return context.l10n.downloadStatusPaused;
        return '${context.l10n.downloadStatusPaused} · '
            '${(task.progress * 100).round()}%';
      case DownloadTaskStatus.completed:
        return task.totalBytes > 0
            ? FileSizeFormatter.format(task.totalBytes)
            : context.l10n.downloadStatusCompleted;
      case DownloadTaskStatus.failed:
        return task.errorMessage ?? context.l10n.downloadStatusFailed;
      case DownloadTaskStatus.canceled:
        return context.l10n.downloadStatusCanceled;
    }
  }

  String _durationLabel(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      padding: EdgeInsets.zero,
      tooltip: tooltip,
      onPressed: onPressed,
      icon: Icon(icon, size: 19),
    );
  }
}

String _statusLabel(BuildContext context, DownloadTaskStatus status) {
  return switch (status) {
    DownloadTaskStatus.queued => context.l10n.downloadStatusQueued,
    DownloadTaskStatus.running => context.l10n.downloadStatusRunning,
    DownloadTaskStatus.waitingToRetry =>
      context.l10n.downloadStatusWaitingToRetry,
    DownloadTaskStatus.paused => context.l10n.downloadStatusPaused,
    DownloadTaskStatus.completed => context.l10n.downloadStatusCompleted,
    DownloadTaskStatus.failed => context.l10n.downloadStatusFailed,
    DownloadTaskStatus.canceled => context.l10n.downloadStatusCanceled,
  };
}

IconData _statusIcon(DownloadTaskStatus status) {
  return switch (status) {
    DownloadTaskStatus.queued => Icons.schedule_rounded,
    DownloadTaskStatus.running => Icons.downloading_rounded,
    DownloadTaskStatus.waitingToRetry => Icons.sync_rounded,
    DownloadTaskStatus.paused => Icons.pause_circle_filled_rounded,
    DownloadTaskStatus.completed => Icons.check_circle_rounded,
    DownloadTaskStatus.failed => Icons.error_rounded,
    DownloadTaskStatus.canceled => Icons.cancel_rounded,
  };
}

Color _statusColor(BuildContext context, DownloadTaskStatus status) {
  final colorScheme = Theme.of(context).colorScheme;
  return switch (status) {
    DownloadTaskStatus.queued => colorScheme.secondary,
    DownloadTaskStatus.running => colorScheme.primary,
    DownloadTaskStatus.waitingToRetry => Colors.orange.shade700,
    DownloadTaskStatus.paused => colorScheme.tertiary,
    DownloadTaskStatus.completed => Colors.green.shade700,
    DownloadTaskStatus.failed => colorScheme.error,
    DownloadTaskStatus.canceled => colorScheme.onSurfaceVariant,
  };
}
