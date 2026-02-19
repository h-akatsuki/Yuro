import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/common/utils/work_localizations.dart';
import 'package:flutter/material.dart';
import 'package:asmrapp/l10n/l10n.dart';

class WorkTagsPanel extends StatelessWidget {
  final Work work;

  const WorkTagsPanel({
    super.key,
    required this.work,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final circleName = work.localizedCircleName();

    return Wrap(
      spacing: 4,
      runSpacing: 2,
      children: [
        if (circleName.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              circleName,
              style: TextStyle(
                fontSize: 10,
                color: Colors.orange[700],
              ),
            ),
          ),
        ...?work.vas?.map((va) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                va['name'] ?? '',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.green[700],
                ),
              ),
            )),
        if (work.hasSubtitle == true)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              context.l10n.subtitleTag,
              style: TextStyle(
                fontSize: 10,
                color: Colors.blue[700],
              ),
            ),
          ),
        ...(work.tags ?? const [])
            .map((tag) => tag.localizedName(locale))
            .where((localizedName) => localizedName.isNotEmpty)
            .map(
              (localizedName) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  localizedName,
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}
