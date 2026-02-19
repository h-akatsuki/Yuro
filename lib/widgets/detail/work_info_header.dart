import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/common/utils/work_localizations.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:asmrapp/widgets/common/tag_chip.dart';
import 'package:asmrapp/widgets/detail/work_stats_info.dart';
import 'package:flutter/material.dart';
import 'package:asmrapp/l10n/l10n.dart';

class WorkInfoHeader extends StatelessWidget {
  final Work work;

  const WorkInfoHeader({
    super.key,
    required this.work,
  });

  void _onTagTap(BuildContext context, String keyword) {
    if (keyword.isEmpty) return;

    AppLogger.debug('点击标签: $keyword');
    Navigator.pushNamed(
      context,
      '/search',
      arguments: keyword,
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localizedTitle = work.localizedTitle(locale);
    final circleName = work.localizedCircleName();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizedTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        WorkStatsInfo(work: work),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (circleName.isNotEmpty)
              TagChip(
                text: circleName,
                backgroundColor: Colors.orange.withValues(alpha: 0.2),
                textColor: Colors.orange[700],
                onTap: () => _onTagTap(context, circleName),
              ),
            ...?work.vas?.map(
              (va) => TagChip(
                text: va['name'] ?? '',
                backgroundColor: Colors.green.withValues(alpha: 0.2),
                textColor: Colors.green[700],
                onTap: () => _onTagTap(context, va['name'] ?? ''),
              ),
            ),
            if (work.hasSubtitle == true)
              TagChip(
                text: context.l10n.subtitleTag,
                backgroundColor: Colors.blue.withValues(alpha: 0.2),
                textColor: Colors.blue[700],
              ),
          ],
        ),
      ],
    );
  }
}
