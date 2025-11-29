import 'package:asmrapp/core/audio/models/subtitle.dart';
import 'package:flutter/material.dart';

class LyricLine extends StatelessWidget {
  final Subtitle subtitle;
  final bool isActive;
  final double opacity;
  final VoidCallback? onTap;

  const LyricLine({
    super.key,
    required this.subtitle,
    this.isActive = false,
    this.opacity = 1.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: opacity,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(
              subtitle.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                    height: 1.3,
                    color: isActive
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.7),
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
