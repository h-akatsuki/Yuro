import 'package:flutter/material.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/widgets/work_card/work_card.dart';

class WorkRow extends StatelessWidget {
  final List<Work> works;
  final void Function(Work work)? onWorkTap;
  final double spacing;
  final int columnsCount;

  const WorkRow({
    super.key,
    required this.works,
    this.onWorkTap,
    this.spacing = 8.0,
    this.columnsCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (var i = 0; i < columnsCount; i++) {
      if (i > 0) {
        children.add(SizedBox(width: spacing));
      }

      children.add(
        Expanded(
          child: i < works.length
              ? WorkCard(
                  work: works[i],
                  onTap: onWorkTap != null ? () => onWorkTap!(works[i]) : null,
                )
              : const SizedBox.shrink(),
        ),
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}
