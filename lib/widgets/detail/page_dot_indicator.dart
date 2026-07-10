import 'dart:math' as math;

import 'package:flutter/material.dart';

class PageDotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final int maxVisibleDots;

  const PageDotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.activeColor,
    required this.inactiveColor,
    this.maxVisibleDots = 7,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 1) return const SizedBox.shrink();

    final visibleCount = math.min(count, maxVisibleDots);
    final maxStart = count - visibleCount;
    final start = (currentIndex - visibleCount ~/ 2).clamp(0, maxStart);

    return Semantics(
      label: '${currentIndex + 1} / $count',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(visibleCount, (visibleIndex) {
          final pageIndex = start + visibleIndex;
          final isActive = pageIndex == currentIndex;
          final isClippedEdge =
              count > visibleCount &&
              ((visibleIndex == 0 && start > 0) ||
                  (visibleIndex == visibleCount - 1 && start < maxStart));
          final size = isActive ? 8.0 : (isClippedEdge ? 4.0 : 6.0);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: size,
            height: size,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isActive ? activeColor : inactiveColor,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}
