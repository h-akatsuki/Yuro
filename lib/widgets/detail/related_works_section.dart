import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/widgets/work_card/work_card.dart';
import 'package:flutter/material.dart';

class RelatedWorksSection extends StatelessWidget {
  static const double _cardWidth = 188;
  static const double _listHeight = 330;

  final List<Work> works;
  final bool isLoading;
  final String? error;
  final bool hasRecommendations;
  final VoidCallback? onSeeAll;
  final VoidCallback? onRetry;
  final ValueChanged<Work> onWorkTap;

  const RelatedWorksSection({
    super.key,
    required this.works,
    required this.isLoading,
    required this.error,
    required this.hasRecommendations,
    required this.onSeeAll,
    required this.onWorkTap,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
            child: Row(
              children: [
                Text(
                  context.l10n.similarWorksTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: hasRecommendations ? onSeeAll : null,
                  icon: const Icon(Icons.chevron_right),
                  label: Text(context.l10n.similarWorksSeeAll),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: theme.colorScheme.surfaceContainerHighest,
          ),
          _buildBody(context),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: _listHeight,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (works.isEmpty) {
      if (error != null && onRetry != null) {
        return SizedBox(
          height: _listHeight,
          child: Center(
            child: ElevatedButton(
              onPressed: onRetry,
              child: Text(context.l10n.retry),
            ),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text(context.l10n.workActionNoRecommendation),
      );
    }

    return SizedBox(
      height: _listHeight,
      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        scrollDirection: Axis.horizontal,
        itemCount: works.length,
        separatorBuilder: (context, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final work = works[index];
          return SizedBox(
            width: _cardWidth,
            child: HeroMode(
              enabled: false,
              child: WorkCard(
                work: work,
                onTap: () => onWorkTap(work),
              ),
            ),
          );
        },
      ),
    );
  }
}
