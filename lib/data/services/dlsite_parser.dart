import 'package:asmrapp/data/models/dlsite/dlsite_work_detail.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

class DlsitePageData {
  final DlsiteWorkDetail detail;
  final Uri? recommendationsUrl;
  final Uri? relatedArticlesUrl;

  const DlsitePageData({
    required this.detail,
    required this.recommendationsUrl,
    required this.relatedArticlesUrl,
  });
}

class DlsiteReviewsData {
  final List<DlsiteReview> reviews;
  final int totalCount;

  const DlsiteReviewsData({required this.reviews, required this.totalCount});
}

class DlsiteParser {
  static final RegExp _productIdPattern = RegExp(
    r'(RJ\d+)',
    caseSensitive: false,
  );
  static final RegExp _matomeEndpointPattern = RegExp(
    r'''['"](https?:\/\/[^'"]+\/work\/matome\/ajax\/[^'"]+)['"]''',
  );
  static final RegExp _candidateUrlPattern = RegExp(
    r'''(?:https?:)?\/\/[^'",\s\]]+''',
  );

  DlsitePageData parseWorkPage(String source, Uri pageUrl) {
    final document = html_parser.parse(source);
    final canonicalUrl =
        _readUri(
          document.querySelector('link[rel="canonical"]')?.attributes['href'],
          pageUrl,
        ) ??
        pageUrl;
    final productId =
        _extractProductId(canonicalUrl.toString()) ??
        _extractProductId(
          document
              .querySelector('[data-product-id]')
              ?.attributes['data-product-id'],
        ) ??
        '';
    final title = _cleanInlineText(
      document.querySelector('#work_name')?.text ??
          document
              .querySelector('meta[property="og:title"]')
              ?.attributes['content'] ??
          '',
    );
    if (productId.isEmpty || title.isEmpty) {
      throw const FormatException('DLsiteの作品情報を解析できませんでした');
    }

    final imageUrl = _readUri(
      document.querySelector('meta[itemprop="image"]')?.attributes['content'] ??
          document
              .querySelector('meta[property="og:image"]')
              ?.attributes['content'],
      canonicalUrl,
    );
    final circleAnchor = document.querySelector(
      '#work_maker .maker_name a[href]',
    );
    final price = int.tryParse(
      (document
                  .querySelector('meta[itemprop="price"]')
                  ?.attributes['content'] ??
              '')
          .replaceAll(RegExp(r'[^0-9]'), ''),
    );
    final rating = double.tryParse(
      document
              .querySelector('meta[itemprop="ratingValue"]')
              ?.attributes['content'] ??
          '',
    );
    final ratingCount = int.tryParse(
      (document
                  .querySelector('meta[itemprop="ratingCount"]')
                  ?.attributes['content'] ??
              '')
          .replaceAll(RegExp(r'[^0-9]'), ''),
    );

    final workInfo = document
        .querySelectorAll('#work_outline tr')
        .map((row) {
          final label = _cleanInlineText(row.querySelector('th')?.text ?? '');
          final value = _cleanInlineText(row.querySelector('td')?.text ?? '');
          final link = _readUri(
            row.querySelector('td a[href]')?.attributes['href'],
            canonicalUrl,
          );
          return DlsiteWorkInfo(label: label, value: value, url: link);
        })
        .where((item) => item.label.isNotEmpty && item.value.isNotEmpty)
        .toList();

    final descriptionSections = _parseDescriptionSections(
      document,
      canonicalUrl,
    );
    final recommendationsUrl = _readUri(
      document
          .querySelector('.recommend_list[data-type="viewsales2"]')
          ?.attributes['data-href'],
      canonicalUrl,
    );
    final relatedArticlesUrl =
        _findMatomeEndpoint(document, canonicalUrl) ??
        canonicalUrl.resolve(
          '/maniax/work/matome/ajax/=/product_id/$productId.html',
        );

    return DlsitePageData(
      detail: DlsiteWorkDetail(
        productId: productId,
        title: title,
        pageUrl: canonicalUrl,
        imageUrl: imageUrl,
        circleName: _nullableText(circleAnchor?.text),
        circleUrl: _readUri(circleAnchor?.attributes['href'], canonicalUrl),
        price: price,
        rating: rating,
        ratingCount: ratingCount,
        workInfo: workInfo,
        descriptionSections: descriptionSections,
      ),
      recommendationsUrl: recommendationsUrl,
      relatedArticlesUrl: relatedArticlesUrl,
    );
  }

  List<DlsiteRecommendation> parseRecommendations(String source, Uri baseUrl) {
    final fragment = html_parser.parseFragment(source);
    final seen = <String>{};
    final result = <DlsiteRecommendation>[];
    for (final item in fragment.querySelectorAll('li[data-prod]')) {
      final productId = _extractProductId(item.attributes['data-prod']) ?? '';
      final titleAnchor = item.querySelector('a.work_name[href]');
      final title = _cleanInlineText(
        titleAnchor?.attributes['title'] ?? titleAnchor?.text ?? '',
      );
      final url = _readUri(
        titleAnchor?.attributes['href'] ??
            item.querySelector('a.work_thumb[href]')?.attributes['href'],
        baseUrl,
      );
      if (productId.isEmpty || title.isEmpty || url == null) continue;
      if (!seen.add(productId)) continue;

      final imageElement = item.querySelector('img-with-fallback');
      final candidateAttribute =
          imageElement?.attributes[':candidates'] ??
          imageElement?.attributes['candidates'];
      final imageCandidate = candidateAttribute == null
          ? null
          : _candidateUrlPattern.firstMatch(candidateAttribute)?.group(0);
      final fallbackImage = item.querySelector('img');

      result.add(
        DlsiteRecommendation(
          productId: productId,
          title: title,
          url: url,
          imageUrl: _readUri(
            imageCandidate ??
                fallbackImage?.attributes['data-src'] ??
                fallbackImage?.attributes['src'],
            baseUrl,
          ),
          makerName: _nullableText(item.querySelector('.maker_name a')?.text),
          category: _nullableText(item.querySelector('.work_category')?.text),
          priceLabel: _nullableText(
            item.querySelector('.work_price:not(.strike)')?.text,
          ),
        ),
      );
    }
    return result;
  }

  List<DlsiteArticle> parseRelatedArticles(String source, Uri baseUrl) {
    final fragment = html_parser.parseFragment(source);
    final seen = <String>{};
    final result = <DlsiteArticle>[];
    for (final item in fragment.querySelectorAll('.matome_box_inner')) {
      final anchor =
          item.querySelector('.matome_content_title a[href]') ??
          item.querySelector('a[href*="ch.dlsite.com/matome/"]');
      final url = _readUri(anchor?.attributes['href'], baseUrl);
      final image = item.querySelector('img');
      final title = _cleanInlineText(
        anchor?.text ?? image?.attributes['alt'] ?? '',
      );
      if (url == null || title.isEmpty || !seen.add(url.toString())) continue;
      result.add(
        DlsiteArticle(
          title: title,
          url: url,
          imageUrl: _readUri(
            image?.attributes['data-src'] ?? image?.attributes['src'],
            baseUrl,
          ),
        ),
      );
    }
    return result;
  }

  DlsiteReviewsData parseReviews(Map<String, dynamic> json, Uri pageUrl) {
    final rawReviews = json['review_list'];
    if (rawReviews is! List) {
      return const DlsiteReviewsData(reviews: [], totalCount: 0);
    }
    final reviews = <DlsiteReview>[];
    for (final raw in rawReviews.whereType<Map>()) {
      final review = Map<String, dynamic>.from(raw);
      final id = review['member_review_id']?.toString() ?? '';
      final productId = review['workno']?.toString() ?? '';
      final reviewerId = review['reviewer_id']?.toString() ?? '';
      final title = _cleanInlineText(review['review_title']?.toString() ?? '');
      final text = _cleanMultilineText(review['review_text']?.toString() ?? '');
      if (id.isEmpty || title.isEmpty || text.isEmpty) continue;
      final reviewUrl = pageUrl.resolve(
        '/maniax/work/reviewlist/=/reviewer/$reviewerId/product_id/$productId.html',
      );
      reviews.add(
        DlsiteReview(
          id: id,
          title: title,
          text: text,
          author: _nullableText(review['nick_name']?.toString()),
          date: _nullableText(review['entry_date']?.toString()),
          rating: _parseReviewRating(review),
          isPurchased: _isTruthy(review['is_purchased']),
          containsSpoilers: _isTruthy(review['spoiler']),
          helpfulCount:
              int.tryParse(review['good_review']?.toString() ?? '') ?? 0,
          url: reviewUrl,
        ),
      );
    }
    return DlsiteReviewsData(
      reviews: reviews,
      totalCount:
          int.tryParse(json['count']?.toString() ?? '') ?? reviews.length,
    );
  }

  List<DlsiteDescriptionSection> _parseDescriptionSections(
    dom.Document document,
    Uri baseUrl,
  ) {
    final result = <DlsiteDescriptionSection>[];
    final parts = document.querySelectorAll(
      '.work_parts_container .work_parts',
    );
    for (final part in parts) {
      final content = part.querySelector('.work_parts_area') ?? part;
      final blocks = _parseDescriptionBlocks(content, baseUrl);
      if (blocks.isEmpty) continue;
      result.add(
        DlsiteDescriptionSection(
          heading: _nullableText(
            part.querySelector('.work_parts_heading')?.text,
          ),
          blocks: blocks,
          links: _parseTextLinks(content, baseUrl),
        ),
      );
    }
    if (result.isNotEmpty) return result;

    final description = document.querySelector('[itemprop="description"]');
    if (description == null) return const [];
    final blocks = _parseDescriptionBlocks(description, baseUrl);
    if (blocks.isEmpty) return const [];
    return [
      DlsiteDescriptionSection(
        heading: null,
        blocks: blocks,
        links: _parseTextLinks(description, baseUrl),
      ),
    ];
  }

  List<DlsiteTextLink> _parseTextLinks(dom.Element element, Uri baseUrl) {
    final seen = <String>{};
    final result = <DlsiteTextLink>[];
    for (final anchor in element.querySelectorAll('a[href]')) {
      final label = _cleanInlineText(anchor.text);
      if (label.isEmpty &&
          anchor.querySelector('img, img-with-fallback') != null) {
        continue;
      }
      final uri = _readUri(anchor.attributes['href'], baseUrl);
      if (uri == null || !seen.add(uri.toString())) continue;
      result.add(
        DlsiteTextLink(label: label.isEmpty ? uri.host : label, url: uri),
      );
    }
    return result;
  }

  Uri? _findMatomeEndpoint(dom.Document document, Uri baseUrl) {
    for (final script in document.querySelectorAll('script')) {
      final match = _matomeEndpointPattern.firstMatch(script.text);
      if (match != null) return _readUri(match.group(1), baseUrl);
    }
    return null;
  }

  List<DlsiteDescriptionBlock> _parseDescriptionBlocks(
    dom.Element element,
    Uri baseUrl,
  ) {
    final result = <DlsiteDescriptionBlock>[];
    final textBuffer = StringBuffer();
    final seenImages = <String>{};

    void flushText() {
      final text = _cleanMultilineText(textBuffer.toString());
      textBuffer.clear();
      if (text.isNotEmpty) {
        result.add(DlsiteDescriptionTextBlock(text: text));
      }
    }

    void visit(dom.Node node) {
      if (node is dom.Text) {
        textBuffer.write(node.data);
        return;
      }
      if (node is! dom.Element) return;
      final tag = node.localName;
      if (const {'script', 'style', 'noscript', 'svg'}.contains(tag)) return;
      if (tag == 'br') {
        textBuffer.write('\n');
        return;
      }
      if (tag == 'img' || tag == 'img-with-fallback') {
        final image = _parseDescriptionImage(node, baseUrl);
        if (image != null && seenImages.add(image.imageUrl.toString())) {
          flushText();
          result.add(image);
        }
        return;
      }
      final block = const {'p', 'div', 'h2', 'h3', 'h4', 'li'}.contains(tag);
      if (block &&
          textBuffer.isNotEmpty &&
          !textBuffer.toString().endsWith('\n')) {
        textBuffer.write('\n');
      }
      for (final child in node.nodes) {
        visit(child);
      }
      if (block && !textBuffer.toString().endsWith('\n')) {
        textBuffer.write('\n');
      }
    }

    visit(element);
    flushText();
    return result;
  }

  DlsiteDescriptionImageBlock? _parseDescriptionImage(
    dom.Element image,
    Uri baseUrl,
  ) {
    final candidates =
        image.attributes[':candidates'] ?? image.attributes['candidates'];
    final candidateUrl = candidates == null
        ? null
        : _candidateUrlPattern.firstMatch(candidates)?.group(0);
    final pictureSource = image.parent?.localName == 'picture'
        ? image.parent?.querySelector('source')
        : null;
    final sources = <String?>[
      image.attributes['data-src'],
      image.attributes['data-original'],
      image.attributes['data-lazy-src'],
      _lastSrcsetUrl(image.attributes['data-srcset']),
      _lastSrcsetUrl(image.attributes['srcset']),
      candidateUrl,
      _lastSrcsetUrl(pictureSource?.attributes['srcset']),
      image.attributes['src'],
    ];
    Uri? imageUrl;
    for (final source in sources) {
      imageUrl = _readUri(source, baseUrl);
      if (imageUrl != null) break;
    }
    if (imageUrl == null) return null;

    final width = int.tryParse(
      image.attributes['width'] ?? image.attributes['data-width'] ?? '',
    );
    final height = int.tryParse(
      image.attributes['height'] ?? image.attributes['data-height'] ?? '',
    );
    if (width != null && height != null && width <= 2 && height <= 2) {
      return null;
    }

    dom.Element? parentLink;
    dom.Element? ancestor = image.parent;
    while (ancestor != null) {
      if (ancestor.localName == 'a') {
        parentLink = ancestor;
        break;
      }
      ancestor = ancestor.parent;
    }
    return DlsiteDescriptionImageBlock(
      imageUrl: imageUrl,
      linkUrl: _readUri(parentLink?.attributes['href'], baseUrl),
      alt: _nullableText(image.attributes['alt'] ?? image.attributes['title']),
      width: width,
      height: height,
    );
  }

  String? _lastSrcsetUrl(String? srcset) {
    final normalized = srcset?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    final candidate = normalized.split(',').last.trim();
    if (candidate.isEmpty) return null;
    return candidate.split(RegExp(r'\s+')).first;
  }

  int? _parseReviewRating(Map<String, dynamic> review) {
    final direct = int.tryParse(review['rate']?.toString() ?? '');
    if (direct != null && direct >= 1 && direct <= 5) return direct;
    final rateNum = int.tryParse(review['rate_num']?.toString() ?? '');
    if (rateNum == null) return null;
    final normalized = (rateNum / 10).round();
    return normalized >= 1 && normalized <= 5 ? normalized : null;
  }

  bool _isTruthy(Object? value) {
    return value == true || value?.toString() == '1';
  }

  String? _extractProductId(String? value) {
    final match = _productIdPattern.firstMatch(value ?? '');
    return match?.group(1)?.toUpperCase();
  }

  Uri? _readUri(String? value, Uri baseUrl) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    final uri = Uri.tryParse(normalized);
    if (uri == null) return null;
    final resolved = uri.hasScheme ? uri : baseUrl.resolveUri(uri);
    if (resolved.scheme != 'http' && resolved.scheme != 'https') return null;
    return resolved;
  }

  String? _nullableText(String? value) {
    final normalized = _cleanInlineText(value ?? '');
    return normalized.isEmpty ? null : normalized;
  }

  String _cleanInlineText(String value) {
    return value.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String _cleanMultilineText(String value) {
    return value
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .split('\n')
        .map((line) => line.replaceAll(RegExp(r'[\t ]+'), ' ').trim())
        .join('\n')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }
}
