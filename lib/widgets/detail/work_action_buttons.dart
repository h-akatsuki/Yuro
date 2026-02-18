import 'package:asmrapp/data/models/mark_status.dart';
import 'package:flutter/material.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/common/extensions/mark_status_localizations.dart';

class WorkActionButtons extends StatelessWidget {
  final VoidCallback onFavoriteTap;
  final bool loadingFavorite;
  final VoidCallback onMarkTap;
  final MarkStatus? currentMarkStatus;
  final bool loadingMark;
  final VoidCallback? onDownloadTap;
  final bool loadingDownload;

  const WorkActionButtons({
    super.key,
    required this.onFavoriteTap,
    this.loadingFavorite = false,
    required this.onMarkTap,
    this.currentMarkStatus,
    this.loadingMark = false,
    this.onDownloadTap,
    this.loadingDownload = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 12,
        runSpacing: 8,
        children: [
          _ActionButton(
            icon: Icons.favorite_border,
            label: context.l10n.workActionFavorite,
            onTap: onFavoriteTap,
            loading: loadingFavorite,
          ),
          _ActionButton(
            icon: Icons.bookmark_border,
            label: currentMarkStatus?.localizedLabel(context.l10n) ??
                context.l10n.workActionMark,
            onTap: onMarkTap,
            loading: loadingMark,
          ),
          _ActionButton(
            icon: Icons.star_border,
            label: context.l10n.workActionRate,
            onTap: () {
              // TODO: 实现评分功能
            },
          ),
          _ActionButton(
            icon: Icons.download_outlined,
            label: context.l10n.workActionDownload,
            onTap: onDownloadTap,
            loading: loadingDownload,
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool loading;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final disabled = onTap == null && !loading;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.primary,
                ),
              )
            else
              Icon(
                icon,
                color: disabled
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.38)
                    : null,
              ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: disabled
                    ? theme.colorScheme.onSurface.withValues(alpha: 0.38)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
