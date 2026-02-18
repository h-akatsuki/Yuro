import 'package:flutter/material.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:asmrapp/utils/file_size_formatter.dart';

class WorkFileItem extends StatelessWidget {
  final Child file;
  final double indentation;
  final Function(Child file)? onFileTap;

  const WorkFileItem({
    super.key,
    required this.file,
    required this.indentation,
    this.onFileTap,
  });

  @override
  Widget build(BuildContext context) {
    final isAudio = FilePreviewUtils.isAudio(file);
    final isImage = FilePreviewUtils.isImage(file);
    final isText = FilePreviewUtils.isText(file);
    final isInteractive = isAudio || isImage || isText;
    final colorScheme = Theme.of(context).colorScheme;

    final IconData iconData;
    final Color iconColor;
    if (isAudio) {
      iconData = Icons.audio_file;
      iconColor = Colors.green;
    } else if (isImage) {
      iconData = Icons.image;
      iconColor = Colors.orange;
    } else if (isText) {
      iconData = Icons.text_snippet;
      iconColor = Colors.teal;
    } else {
      iconData = Icons.insert_drive_file;
      iconColor = Colors.blue;
    }

    return Padding(
      padding: EdgeInsets.only(left: indentation),
      child: ListTile(
        title: Text(
          file.title ?? '',
          style: TextStyle(
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          FileSizeFormatter.format(file.size),
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        leading: Icon(iconData, color: iconColor),
        dense: true,
        onTap: isInteractive
            ? () {
                AppLogger.debug('点击文件: ${file.title}, type=${file.type}');
                onFileTap?.call(file);
              }
            : null,
      ),
    );
  }
}
