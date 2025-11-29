import 'package:flutter/material.dart';
import 'package:asmrapp/l10n/l10n.dart';

class FilterPanel extends StatelessWidget {
  final bool expanded;
  final bool hasSubtitle;
  final String orderField;
  final bool isDescending;
  final ValueChanged<bool> onSubtitleChanged;
  final ValueChanged<String> onOrderFieldChanged;
  final ValueChanged<bool> onSortDirectionChanged;

  const FilterPanel({
    super.key,
    this.expanded = false,
    required this.hasSubtitle,
    required this.orderField,
    required this.isDescending,
    required this.onSubtitleChanged,
    required this.onOrderFieldChanged,
    required this.onSortDirectionChanged,
  });

  String _getOrderFieldText(BuildContext context, String field) {
    switch (field) {
      case 'create_date':
        return context.l10n.orderFieldCollectionTime;
      case 'release':
        return context.l10n.orderFieldReleaseDate;
      case 'dl_count':
        return context.l10n.orderFieldSales;
      case 'price':
        return context.l10n.orderFieldPrice;
      case 'rate_average_2dp':
        return context.l10n.orderFieldRating;
      case 'review_count':
        return context.l10n.orderFieldReviewCount;
      case 'id':
        return context.l10n.orderFieldId;
      case 'rating':
        return context.l10n.orderFieldMyRating;
      case 'nsfw':
        return context.l10n.orderFieldAllAges;
      case 'random':
        return context.l10n.orderFieldRandom;
      default:
        return context.l10n.orderLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // 字幕过滤
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () => onSubtitleChanged(!hasSubtitle),
                  borderRadius: BorderRadius.circular(7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          hasSubtitle
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 20,
                          color: hasSubtitle
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          context.l10n.subtitleAvailable,
                          style: TextStyle(
                            color: hasSubtitle
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // 排序字段
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PopupMenuButton<String>(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(_getOrderFieldText(context, orderField)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, size: 20),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  _buildOrderMenuItem(context, 'create_date'),
                  _buildOrderMenuItem(context, 'release'),
                  _buildOrderMenuItem(context, 'dl_count'),
                  _buildOrderMenuItem(context, 'price'),
                  _buildOrderMenuItem(context, 'rate_average_2dp'),
                  _buildOrderMenuItem(context, 'review_count'),
                  _buildOrderMenuItem(context, 'id'),
                  _buildOrderMenuItem(context, 'rating'),
                  _buildOrderMenuItem(context, 'nsfw'),
                  _buildOrderMenuItem(context, 'random'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // 排序方向
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context)
                      .colorScheme
                      .outline
                      .withValues(alpha: 0.5),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: () => onSortDirectionChanged(!isDescending),
                  borderRadius: BorderRadius.circular(7),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(isDescending
                            ? context.l10n.orderDirectionDesc
                            : context.l10n.orderDirectionAsc),
                        const SizedBox(width: 4),
                        Icon(
                          isDescending
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          size: 20,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildOrderMenuItem(
    BuildContext context,
    String value,
  ) {
    return PopupMenuItem(
      value: value,
      child: Text(_getOrderFieldText(context, value)),
    );
  }
}
