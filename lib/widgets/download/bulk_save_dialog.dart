import 'dart:async';

import 'package:asmrapp/core/download/bulk_save_controller.dart';
import 'package:asmrapp/core/download/download_directory_controller.dart';
import 'package:asmrapp/data/models/my_lists/my_playlists/playlist.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/common/utils/playlist_localizations.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> showBulkSaveDialog(
  BuildContext context, {
  Playlist? playlist,
  String? playlistName,
  bool allPlaylists = false,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => BulkSaveDialog(
      playlist: playlist,
      playlistName: playlistName,
      allPlaylists: allPlaylists,
    ),
  );
}

class BulkSaveDialog extends StatefulWidget {
  final Playlist? playlist;
  final String? playlistName;
  final bool allPlaylists;

  const BulkSaveDialog({
    super.key,
    this.playlist,
    this.playlistName,
    this.allPlaylists = false,
  });

  @override
  State<BulkSaveDialog> createState() => _BulkSaveDialogState();
}

class _BulkSaveDialogState extends State<BulkSaveDialog> {
  bool _selectingDirectory = false;

  @override
  Widget build(BuildContext context) {
    final saveController = context.watch<BulkSaveController>();
    final directoryController = context.watch<DownloadDirectoryController>();
    final path = directoryController.bulkSaveDirectoryPath;
    final l10n = context.l10n;
    final title = widget.allPlaylists
        ? l10n.bulkSaveAllPlaylistsTitle
        : widget.playlist == null
        ? l10n.bulkSaveLikesTitle
        : l10n.bulkSavePlaylistTitle(widget.playlistName ?? '');

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.save_alt_rounded),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.bulkSaveDescription),
              const SizedBox(height: 18),
              Text(
                l10n.bulkSaveDirectoryLabel,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.48),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  path?.isNotEmpty == true
                      ? path!
                      : l10n.bulkSaveDirectoryUnset,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: saveController.isRunning || _selectingDirectory
                    ? null
                    : () => _selectDirectory(directoryController),
                icon: _selectingDirectory
                    ? const SizedBox.square(
                        dimension: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.folder_open_rounded),
                label: Text(l10n.bulkSaveChooseDirectory),
              ),
              if (saveController.state != BulkSaveRunState.idle) ...[
                const SizedBox(height: 20),
                _buildStatus(context, saveController),
              ],
            ],
          ),
        ),
      ),
      actions: [
        if (saveController.isRunning)
          TextButton.icon(
            onPressed: saveController.cancel,
            icon: const Icon(Icons.stop_circle_outlined),
            label: Text(l10n.bulkSaveCancel),
          )
        else ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton.icon(
            key: const ValueKey('bulk-save-start'),
            onPressed: path?.isNotEmpty == true
                ? () => _start(saveController)
                : null,
            icon: const Icon(Icons.save_alt_rounded),
            label: Text(l10n.bulkSaveStart),
          ),
        ],
      ],
    );
  }

  Widget _buildStatus(BuildContext context, BulkSaveController controller) {
    final l10n = context.l10n;
    switch (controller.state) {
      case BulkSaveRunState.idle:
        return const SizedBox.shrink();
      case BulkSaveRunState.running:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.bulkSaveRunning,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                Text(
                  l10n.bulkSaveProgress(
                    controller.processedWorks,
                    controller.totalWorks,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: controller.overallProgress),
            if (controller.currentWorkCode != null) ...[
              const SizedBox(height: 8),
              Text(l10n.bulkSaveCurrentWork(controller.currentWorkCode!)),
            ],
            if (controller.currentFileName != null) ...[
              const SizedBox(height: 4),
              Text(
                controller.currentFileName!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              LinearProgressIndicator(
                value: controller.currentFileProgress,
                minHeight: 3,
              ),
            ],
          ],
        );
      case BulkSaveRunState.completed:
        return _ResultMessage(
          icon: Icons.check_circle_outline_rounded,
          color: Theme.of(context).colorScheme.primary,
          message: _resultText(context, controller.result),
        );
      case BulkSaveRunState.cancelled:
        return _ResultMessage(
          icon: Icons.info_outline_rounded,
          color: Theme.of(context).colorScheme.secondary,
          message: l10n.bulkSaveCancelled,
        );
      case BulkSaveRunState.failed:
        return _ResultMessage(
          icon: Icons.error_outline_rounded,
          color: Theme.of(context).colorScheme.error,
          message: l10n.bulkSaveFailed(controller.error ?? ''),
        );
    }
  }

  String _resultText(BuildContext context, BulkSaveResult? result) {
    if (result == null) return '';
    final l10n = context.l10n;
    return <String>[
      l10n.bulkSaveCompleted(
        result.savedWorks,
        result.skippedWorks,
        result.failedWorks,
      ),
      l10n.bulkSaveReuseSummary(result.reusedFiles, result.downloadedFiles),
    ].join('\n');
  }

  Future<void> _selectDirectory(DownloadDirectoryController controller) async {
    setState(() => _selectingDirectory = true);
    try {
      final path = await getDirectoryPath(
        initialDirectory: controller.bulkSaveDirectoryPath,
        confirmButtonText: context.l10n.confirm,
      );
      if (path == null || path.trim().isEmpty) return;
      await controller.setBulkSaveDirectoryPath(path);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.operationFailed(error.toString()))),
      );
    } finally {
      if (mounted) setState(() => _selectingDirectory = false);
    }
  }

  void _start(BulkSaveController controller) {
    final locale = Localizations.localeOf(context);
    if (widget.allPlaylists) {
      final l10n = context.l10n;
      unawaited(
        controller.saveAllPlaylists(
          locale: locale,
          playlistNameFor: (playlist) =>
              localizedPlaylistName(playlist.name, l10n),
        ),
      );
      return;
    }
    if (widget.playlist == null) {
      unawaited(controller.saveLikes(locale: locale));
      return;
    }
    unawaited(
      controller.savePlaylist(
        playlist: widget.playlist!,
        playlistName: widget.playlistName ?? '',
        locale: locale,
      ),
    );
  }
}

class _ResultMessage extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String message;

  const _ResultMessage({
    required this.icon,
    required this.color,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Expanded(child: Text(message)),
      ],
    );
  }
}
