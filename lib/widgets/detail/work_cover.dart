import 'package:asmrapp/widgets/detail/page_dot_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WorkCover extends StatefulWidget {
  final String imageUrl;
  final List<String> additionalImageUrls;
  final int workId;
  final String sourceId;
  final String? releaseDate;
  final String? heroTag;

  const WorkCover({
    super.key,
    required this.imageUrl,
    this.additionalImageUrls = const <String>[],
    required this.workId,
    required this.sourceId,
    this.releaseDate,
    this.heroTag,
  });

  @override
  State<WorkCover> createState() => _WorkCoverState();
}

class _WorkCoverState extends State<WorkCover> {
  late PageController _pageController;
  late List<String> _imageUrls;
  var _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _imageUrls = _resolveImageUrls();
    _pageController = _createPageController();
  }

  @override
  void didUpdateWidget(covariant WorkCover oldWidget) {
    super.didUpdateWidget(oldWidget);
    final nextImageUrls = _resolveImageUrls();
    if (_sameUrls(_imageUrls, nextImageUrls)) return;

    _imageUrls = nextImageUrls;
    _currentIndex = 0;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageController.hasClients || _imageUrls.length <= 1) {
        return;
      }
      _pageController.jumpToPage(_imageUrls.length * 1000);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  PageController _createPageController() {
    final initialPage = _imageUrls.length > 1 ? _imageUrls.length * 1000 : 0;
    return PageController(initialPage: initialPage);
  }

  List<String> _resolveImageUrls() {
    final urls = <String>[];
    final seen = <String>{};
    for (final candidate in <String>[
      widget.imageUrl,
      ...widget.additionalImageUrls,
    ]) {
      final url = candidate.trim();
      if (url.isNotEmpty && seen.add(url)) urls.add(url);
    }
    return urls;
  }

  bool _sameUrls(List<String> first, List<String> second) {
    if (first.length != second.length) return false;
    for (var index = 0; index < first.length; index++) {
      if (first[index] != second[index]) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    Widget content = Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: screenHeight),
        child: AspectRatio(
          aspectRatio: 195 / 146,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildGallery(context),
              if (widget.sourceId.isNotEmpty)
                Positioned(
                  left: 10,
                  top: 10,
                  child: _MetadataBadge(text: widget.sourceId),
                ),
              if (widget.releaseDate?.trim().isNotEmpty ?? false)
                Positioned(
                  right: 10,
                  top: 10,
                  child: _MetadataBadge(text: widget.releaseDate!),
                ),
              if (_imageUrls.length > 1)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 12,
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.42),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: PageDotIndicator(
                          count: _imageUrls.length,
                          currentIndex: _currentIndex,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withValues(alpha: 0.48),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    if (widget.heroTag != null) {
      content = Hero(tag: widget.heroTag!, child: content);
    }
    return content;
  }

  Widget _buildGallery(BuildContext context) {
    if (_imageUrls.isEmpty) {
      return ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    return PageView.builder(
      key: ValueKey(_imageUrls.join('\n')),
      controller: _pageController,
      itemCount: _imageUrls.length == 1 ? 1 : null,
      onPageChanged: (page) {
        final index = page % _imageUrls.length;
        if (index == _currentIndex || !mounted) return;
        setState(() => _currentIndex = index);
      },
      itemBuilder: (context, page) {
        final imageUrl = _imageUrls[page % _imageUrls.length];
        return CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, _) => ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Center(child: CircularProgressIndicator()),
          ),
          errorWidget: (context, _, _) => ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Icon(
              Icons.broken_image_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}

class _MetadataBadge extends StatelessWidget {
  final String text;

  const _MetadataBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.66),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        child: Text(
          text,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
