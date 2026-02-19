import 'package:flutter/material.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/data/models/works/tag.dart';
import 'package:asmrapp/common/utils/work_localizations.dart';
import 'package:asmrapp/widgets/common/tag_chip.dart';
import 'package:asmrapp/widgets/detail/work_info_header.dart';
import 'package:asmrapp/utils/logger.dart';

class WorkInfo extends StatelessWidget {
  final Work work;

  const WorkInfo({
    super.key,
    required this.work,
  });

  void _onTagTap(BuildContext context, Tag tag, Locale locale) {
    final keyword = (tag.name ?? '').trim().isNotEmpty
        ? (tag.name ?? '').trim()
        : tag.localizedName(locale);
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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WorkInfoHeader(work: work),
          const SizedBox(height: 8),
          if (work.tags != null && work.tags!.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: work.tags!
                  .where((tag) => tag.localizedName(locale).isNotEmpty)
                  .map((tag) => TagChip(
                        text: tag.localizedName(locale),
                        onTap: () => _onTagTap(context, tag, locale),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}
