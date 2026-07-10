import 'package:asmrapp/common/utils/file_preview_utils.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/l10n/l10n.dart';
import 'package:asmrapp/widgets/detail/page_dot_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  PageController? _imagePageController;
  var _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _imageMode = FilePreviewUtils.isImage(widget.file);
    _imageFiles = _resolveImageFiles();
    _currentImageIndex = _resolveInitialImageIndex();
    if (_imageMode) {
      final initialPage = _imageFiles.length > 1
          ? (_imageFiles.length * 1000) + _currentImageIndex
          : 0;
      _imagePageController = PageController(initialPage: initialPage);
    }
  }

  @override
  void dispose() {
    _imagePageController?.dispose();
    super.dispose();
  }

  List<Child> _resolveImageFiles() {
    if (!_imageMode) return const <Child>[];

    final candidates = widget.imageFiles;
    if (candidates == null || candidates.isEmpty) return <Child>[widget.file];

    final imageCandidates = candidates
        .where(FilePreviewUtils.isImage)
        .toList(growable: false);
    return imageCandidates.isEmpty ? <Child>[widget.file] : imageCandidates;
  }

  int _resolveInitialImageIndex() {
    if (!_imageMode) return 0;

    final explicitIndex = widget.initialImageIndex;
    if (explicitIndex != null &&
        explicitIndex >= 0 &&
        explicitIndex < _imageFiles.length) {
      return explicitIndex;
    }

    final identityIndex = _imageFiles.indexWhere(
      (file) => identical(file, widget.file),
    );
    if (identityIndex >= 0) return identityIndex;

    final equalityIndex = _imageFiles.indexOf(widget.file);
    return equalityIndex >= 0 ? equalityIndex : 0;
  }

  Child get _currentFile =>
      _imageMode ? _imageFiles[_currentImageIndex] : widget.file;

  @override
  Widget build(BuildContext context) {
    final imageForegroundColor = _imageMode ? Colors.white : null;

    return Dialog.fullscreen(
      child: Scaffold(
        backgroundColor: _imageMode
            ? Colors.black
            : Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: _imageMode ? Colors.black : null,
          foregroundColor: imageForegroundColor,
          title: Text(
            _currentFile.title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: _imageMode
            ? _ImagePreview(
                files: _imageFiles,
                controller: _imagePageController!,
                currentImageIndex: _currentImageIndex,
                onPageChanged: (page) {
                  final index = page % _imageFiles.length;
                  if (index == _currentImageIndex) return;
                  setState(() => _currentImageIndex = index);
                },
              )
            : _TextPreview(
                file: widget.file,
                loadTextPreview: widget.loadTextPreview,
              ),
      ),
    );
  }
}

class _ImagePreview extends StatelessWidget {
  final List<Child> files;
  final PageController controller;
  final int currentImageIndex;
  final ValueChanged<int> onPageChanged;

  const _ImagePreview({
    required this.files,
    required this.controller,
    required this.currentImageIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: controller,
          itemCount: files.length == 1 ? 1 : null,
          allowImplicitScrolling: true,
          onPageChanged: onPageChanged,
          itemBuilder: (context, page) {
            final file = files[page % files.length];
            return _ZoomableImage(file: file);
          },
        ),
        if (files.length > 1)
          Positioned(
            left: 16,
            right: 16,
            bottom: 12,
            child: SafeArea(
              top: false,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.52),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 7,
                    ),
                    child: PageDotIndicator(
                      count: files.length,
                      currentIndex: currentImageIndex,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withValues(alpha: 0.46),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ZoomableImage extends StatelessWidget {
  final Child file;

  const _ZoomableImage({required this.file});

  @override
  Widget build(BuildContext context) {
    final url = file.mediaDownloadUrl;
    if (url == null || url.isEmpty) {
      return _PreviewMessage(
        message: context.l10n.playUrlMissing,
        onDarkBackground: true,
      );
    }

    return InteractiveViewer(
      key: ValueKey(url),
      minScale: 1,
      maxScale: 5,
      child: Center(
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.contain,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, _) => const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
          errorWidget: (context, _, error) => _PreviewMessage(
            message: context.l10n.operationFailed(error.toString()),
            onDarkBackground: true,
          ),
        ),
      ),
    );
  }
}

class _TextPreview extends StatefulWidget {
  final Child file;
  final Future<String> Function(Child file) loadTextPreview;

  const _TextPreview({required this.file, required this.loadTextPreview});

  @override
  State<_TextPreview> createState() => _TextPreviewState();
}

class _TextPreviewState extends State<_TextPreview> {
  final _scrollController = ScrollController();
  late Future<String> _contentFuture;

  @override
  void initState() {
    super.initState();
    _contentFuture = widget.loadTextPreview(widget.file);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _retry() {
    setState(() {
      _contentFuture = widget.loadTextPreview(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _contentFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return _PreviewMessage(
            message: context.l10n.operationFailed(snapshot.error.toString()),
            onRetry: _retry,
          );
        }

        final text = snapshot.data ?? '';
        if (text.trim().isEmpty) {
          return _PreviewMessage(message: context.l10n.emptyContent);
        }

        final width = MediaQuery.sizeOf(context).width;
        final horizontalPadding = width < 600 ? 20.0 : 36.0;
        final textStyle = _usesMonospace(widget.file.title)
            ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                fontFamily: 'monospace',
              )
            : Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7);

        return SafeArea(
          top: false,
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                40,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 880),
                  child: SizedBox(
                    width: double.infinity,
                    child: SelectableText(text, style: textStyle),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  bool _usesMonospace(String? title) {
    final normalized = title?.toLowerCase() ?? '';
    return const <String>[
      '.json',
      '.xml',
      '.csv',
      '.log',
      '.yaml',
      '.yml',
      '.lrc',
      '.vtt',
      '.srt',
      '.ass',
      '.ssa',
    ].any(normalized.endsWith);
  }
}

class _PreviewMessage extends StatelessWidget {
  final String message;
  final bool onDarkBackground;
  final VoidCallback? onRetry;

  const _PreviewMessage({
    required this.message,
    this.onDarkBackground = false,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final foregroundColor = onDarkBackground
        ? Colors.white70
        : colorScheme.onSurfaceVariant;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: foregroundColor, size: 36),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: foregroundColor),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(context.l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
