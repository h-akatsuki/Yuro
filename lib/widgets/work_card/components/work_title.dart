import 'package:flutter/material.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:asmrapp/common/utils/work_localizations.dart';

class WorkTitle extends StatelessWidget {
  final Work work;

  const WorkTitle({
    super.key,
    required this.work,
  });

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);

    return Text(
      work.localizedTitle(locale),
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14,
          ),
    );
  }
}
