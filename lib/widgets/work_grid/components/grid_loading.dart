import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:asmrapp/presentation/layouts/work_layout_config.dart';

class GridLoading extends StatelessWidget {
  const GridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = DeviceType.fromWidth(constraints.maxWidth);
        final columnsCount = WorkLayoutConfig.getColumnsCount(deviceType);
        final spacing = WorkLayoutConfig.getSpacing(deviceType);
        final padding = WorkLayoutConfig.getPadding(deviceType);

        return Shimmer.fromColors(
          baseColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          highlightColor: Theme.of(context).colorScheme.surface,
          child: GridView.builder(
            padding: padding,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnsCount,
              childAspectRatio: 0.75,
              crossAxisSpacing: spacing,
              mainAxisSpacing: spacing,
            ),
            itemCount: columnsCount * 3,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
