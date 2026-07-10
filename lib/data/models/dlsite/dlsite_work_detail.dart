class DlsiteWorkDetail {
  final String productId;
  final String title;
  final Uri pageUrl;
  final Uri? imageUrl;
  final String? circleName;
  final Uri? circleUrl;
  final int? price;
  final double? rating;
  final int? ratingCount;
  final List<DlsiteWorkInfo> workInfo;
  final List<DlsiteDescriptionSection> descriptionSections;
  final List<DlsiteRecommendation> recommendations;
  final List<DlsiteArticle> relatedArticles;
  final List<DlsiteReview> reviews;
  final int reviewCount;

  const DlsiteWorkDetail({
    required this.productId,
    required this.title,
    required this.pageUrl,
    required this.imageUrl,
    required this.circleName,
    required this.circleUrl,
    required this.price,
    required this.rating,
    required this.ratingCount,
    required this.workInfo,
    required this.descriptionSections,
    this.recommendations = const [],
    this.relatedArticles = const [],
    this.reviews = const [],
    this.reviewCount = 0,
  });

  DlsiteWorkDetail copyWith({
    List<DlsiteRecommendation>? recommendations,
    List<DlsiteArticle>? relatedArticles,
    List<DlsiteReview>? reviews,
    int? reviewCount,
  }) {
    return DlsiteWorkDetail(
      productId: productId,
      title: title,
      pageUrl: pageUrl,
      imageUrl: imageUrl,
      circleName: circleName,
      circleUrl: circleUrl,
      price: price,
      rating: rating,
      ratingCount: ratingCount,
      workInfo: workInfo,
      descriptionSections: descriptionSections,
      recommendations: recommendations ?? this.recommendations,
      relatedArticles: relatedArticles ?? this.relatedArticles,
      reviews: reviews ?? this.reviews,
      reviewCount: reviewCount ?? this.reviewCount,
    );
  }
}

class DlsiteWorkInfo {
  final String label;
  final String value;
  final Uri? url;

  const DlsiteWorkInfo({required this.label, required this.value, this.url});
}

class DlsiteDescriptionSection {
  final String? heading;
  final List<DlsiteDescriptionBlock> blocks;
  final List<DlsiteTextLink> links;

  const DlsiteDescriptionSection({
    required this.heading,
    required this.blocks,
    this.links = const [],
  });

  String get text => blocks
      .whereType<DlsiteDescriptionTextBlock>()
      .map((block) => block.text)
      .join('\n\n');
}

sealed class DlsiteDescriptionBlock {
  const DlsiteDescriptionBlock();
}

class DlsiteDescriptionTextBlock extends DlsiteDescriptionBlock {
  final String text;

  const DlsiteDescriptionTextBlock({required this.text});
}

class DlsiteDescriptionImageBlock extends DlsiteDescriptionBlock {
  final Uri imageUrl;
  final Uri? linkUrl;
  final String? alt;
  final int? width;
  final int? height;

  const DlsiteDescriptionImageBlock({
    required this.imageUrl,
    required this.linkUrl,
    required this.alt,
    required this.width,
    required this.height,
  });

  double? get aspectRatio {
    final imageWidth = width;
    final imageHeight = height;
    if (imageWidth == null || imageHeight == null || imageHeight <= 0) {
      return null;
    }
    return imageWidth / imageHeight;
  }
}

class DlsiteTextLink {
  final String label;
  final Uri url;

  const DlsiteTextLink({required this.label, required this.url});
}

class DlsiteRecommendation {
  final String productId;
  final String title;
  final Uri url;
  final Uri? imageUrl;
  final String? makerName;
  final String? category;
  final String? priceLabel;

  const DlsiteRecommendation({
    required this.productId,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.makerName,
    required this.category,
    required this.priceLabel,
  });
}

class DlsiteArticle {
  final String title;
  final Uri url;
  final Uri? imageUrl;

  const DlsiteArticle({
    required this.title,
    required this.url,
    required this.imageUrl,
  });
}

class DlsiteReview {
  final String id;
  final String title;
  final String text;
  final String? author;
  final String? date;
  final int? rating;
  final bool isPurchased;
  final bool containsSpoilers;
  final int helpfulCount;
  final Uri url;

  const DlsiteReview({
    required this.id,
    required this.title,
    required this.text,
    required this.author,
    required this.date,
    required this.rating,
    required this.isPurchased,
    required this.containsSpoilers,
    required this.helpfulCount,
    required this.url,
  });
}
