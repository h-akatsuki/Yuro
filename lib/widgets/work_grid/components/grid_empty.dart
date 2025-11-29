import 'package:flutter/material.dart';

class GridEmpty extends StatelessWidget {
  final String? message;
  final Widget? customWidget;

  const GridEmpty({
    super.key,
    this.message,
    this.customWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (customWidget != null) {
      return customWidget!;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 48,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? '暂无内容',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}
