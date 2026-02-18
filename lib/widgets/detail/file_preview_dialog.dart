import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:flutter/material.dart';

class FilePreviewDialog extends StatelessWidget {
  final Child file;
  final Future<String> Function(Child file) loadTextPreview;

  const FilePreviewDialog({
    super.key,
    required this.file,
    required this.loadTextPreview,
  });

  @override
  Widget build(BuildContext context) {
    final title = file.title ?? '';

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SafeArea(
          child: FilePreviewUtils.isImage(file)
              ? _ImagePreview(file: file)
              : _TextPreview(
                  file: file,
                  loadTextPreview: loadTextPreview,
                ),
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final Child file;

  const _ImagePreview({required this.file});

  @override
  Widget build(BuildContext context) {
    final url = file.mediaDownloadUrl;
    if (url == null || url.isEmpty) {
      return _PreviewMessage(message: context.l10n.playUrlMissing);
    }

    return InteractiveViewer(
      minScale: 1,
      maxScale: 4,
      child: Center(
        child: Image.network(
          url,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return _PreviewMessage(
              message: context.l10n.operationFailed(error.toString()),
            );
          },
        ),
      ),
    );
  }
}

class _TextPreview extends StatelessWidget {
  final Child file;
  final Future<String> Function(Child file) loadTextPreview;

  const _TextPreview({
    required this.file,
    required this.loadTextPreview,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadTextPreview(file),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _PreviewMessage(
            message: context.l10n.operationFailed(snapshot.error.toString()),
          );
        }

        final text = snapshot.data ?? '';
        if (text.trim().isEmpty) {
          return _PreviewMessage(message: context.l10n.emptyContent);
        }

        return Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SelectableText(
              text,
              style: const TextStyle(
                height: 1.5,
                fontFamily: 'monospace',
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PreviewMessage extends StatelessWidget {
  final String message;

  const _PreviewMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
