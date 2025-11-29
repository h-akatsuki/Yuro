import 'package:flutter/material.dart';

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

  String _getOrderFieldText(String field) {
    switch (field) {
      case 'create_date':
        return '收录时间';
      case 'release':
        return '发售日期';
      case 'dl_count':
        return '销量';
      case 'price':
        return '价格';
      case 'rate_average_2dp':
        return '评价';
      case 'review_count':
        return '评论数量';
      case 'id':
        return 'RJ号';
      case 'rating':
        return '我的评价';
      case 'nsfw':
        return '全年龄';
      case 'random':
        return '随机';
      default:
        return '排序';
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
                          '有字幕',
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
                      Text(_getOrderFieldText(orderField)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, size: 20),
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                  _buildOrderMenuItem('收录时间', 'create_date'),
                  _buildOrderMenuItem('发售日期', 'release'),
                  _buildOrderMenuItem('销量', 'dl_count'),
                  _buildOrderMenuItem('价格', 'price'),
                  _buildOrderMenuItem('评价', 'rate_average_2dp'),
                  _buildOrderMenuItem('评论数量', 'review_count'),
                  _buildOrderMenuItem('RJ号', 'id'),
                  _buildOrderMenuItem('我的评价', 'rating'),
                  _buildOrderMenuItem('全年龄', 'nsfw'),
                  _buildOrderMenuItem('随机', 'random'),
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
                        Text(isDescending ? '降序' : '升序'),
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

  PopupMenuItem<String> _buildOrderMenuItem(String text, String value) {
    return PopupMenuItem(
      value: value,
      child: Text(text),
    );
  }
}
