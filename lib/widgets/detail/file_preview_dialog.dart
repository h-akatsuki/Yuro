import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:flutter/material.dart';

class FilePreviewDialog extends StatefulWidget {
  final Child file;
  final Future<String> Function(Child file) loadTextPreview;
  final List<Child>? imageFiles;
  final int? initialImageIndex;

  const FilePreviewDialog({
    super.key,
    required this.file,
    required this.loadTextPreview,
    this.imageFiles,
    this.initialImageIndex,
  });

  @override
  State<FilePreviewDialog> createState() => _FilePreviewDialogState();
}

class _FilePreviewDialogState extends State<FilePreviewDialog> {
  late final bool _imageMode;
  late final List<Child> _imageFiles;
  late int _currentImageIndex;

  @override
  void initState() {
    super.initState();
    _imageMode = FilePreviewUtils.isImage(widget.file);
    _imageFiles = _resolveImageFiles();
    _currentImageIndex = _resolveInitialImageIndex();
  }

  List<Child> _resolveImageFiles() {
    if (!_imageMode) {
      return const <Child>[];
    }

    final candidates = widget.imageFiles;
    if (candidates == null || candidates.isEmpty) {
      return <Child>[widget.file];
    }

    final imageCandidates =
        candidates.where(FilePreviewUtils.isImage).toList(growable: false);
    if (imageCandidates.isEmpty) {
      return <Child>[widget.file];
    }

    return imageCandidates;
  }

  int _resolveInitialImageIndex() {
    if (!_imageMode) return 0;

    final explicitIndex = widget.initialImageIndex;
    if (explicitIndex != null &&
        explicitIndex >= 0 &&
        explicitIndex < _imageFiles.length) {
      return explicitIndex;
    }

    final fileIndex = _imageFiles.indexOf(widget.file);
    if (fileIndex >= 0) {
      return fileIndex;
    }

    return 0;
  }

  Child get _currentFile {
    if (_imageMode) {
      return _imageFiles[_currentImageIndex];
    }
    return widget.file;
  }

  bool get _hasPreviousImage => _currentImageIndex > 0;

  bool get _hasNextImage => _currentImageIndex < _imageFiles.length - 1;

  void _showPreviousImage() {
    if (!_hasPreviousImage) return;
    setState(() {
      _currentImageIndex -= 1;
    });
  }

  void _showNextImage() {
    if (!_hasNextImage) return;
    setState(() {
      _currentImageIndex += 1;
    });
  }

  String _dialogTitle() {
    final title = _currentFile.title ?? '';
    if (!_imageMode || _imageFiles.length <= 1) {
      return title;
    }

    final indexText = '[$_currentImageIndex]';
    if (title.isEmpty) {
      return indexText;
    }
    return '$title $indexText';
  }

  @override
  Widget build(BuildContext context) {
    final canNavigateImages = _imageMode && _imageFiles.length > 1;
    final materialLocalizations = MaterialLocalizations.of(context);

    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_dialogTitle()),
          actions: canNavigateImages
              ? [
                  IconButton(
                    tooltip: materialLocalizations.previousPageTooltip,
                    onPressed: _hasPreviousImage ? _showPreviousImage : null,
                    icon: const Icon(Icons.navigate_before),
                  ),
                  IconButton(
                    tooltip: materialLocalizations.nextPageTooltip,
                    onPressed: _hasNextImage ? _showNextImage : null,
                    icon: const Icon(Icons.navigate_next),
                  ),
                ]
              : null,
        ),
        body: SafeArea(
          child: _imageMode
              ? _ImagePreview(
                  file: _currentFile,
                  onPrevious: _hasPreviousImage ? _showPreviousImage : null,
                  onNext: _hasNextImage ? _showNextImage : null,
                  currentImageIndex: _currentImageIndex,
                  maxImageIndex: _imageFiles.length - 1,
                  canNavigateImages: canNavigateImages,
                )
              : _TextPreview(
                  file: widget.file,
                  loadTextPreview: widget.loadTextPreview,
                ),
        ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final Child file;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final int currentImageIndex;
  final int maxImageIndex;
  final bool canNavigateImages;

  const _ImagePreview({
    required this.file,
    required this.onPrevious,
    required this.onNext,
    required this.currentImageIndex,
    required this.maxImageIndex,
    required this.canNavigateImages,
  });

  @override
  Widget build(BuildContext context) {
    final url = file.mediaDownloadUrl;
    if (url == null || url.isEmpty) {
      return _PreviewMessage(message: context.l10n.playUrlMissing);
    }

    final colorScheme = Theme.of(context).colorScheme;
    final materialLocalizations = MaterialLocalizations.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: InteractiveViewer(
            key: ValueKey(url),
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
          ),
        ),
        if (canNavigateImages)
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: IconButton(
                    tooltip: materialLocalizations.previousPageTooltip,
                    onPressed: onPrevious,
                    icon: const Icon(Icons.navigate_before),
                  ),
                ),
                const SizedBox(width: 12),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    child: Text(
                      '$currentImageIndex / $maxImageIndex',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: IconButton(
                    tooltip: materialLocalizations.nextPageTooltip,
                    onPressed: onNext,
                    icon: const Icon(Icons.navigate_next),
                  ),
                ),
              ],
            ),
          ),
      ],
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
