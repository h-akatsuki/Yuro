import 'package:asmrapp/data/models/dlsite/dlsite_work_detail.dart';
import 'package:asmrapp/data/services/dlsite_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final parser = DlsiteParser();
  final pageUrl = Uri.parse(
    'https://www.dlsite.com/maniax/work/=/product_id/RJ01234567.html',
  );

  group('DlsiteParser', () {
    test('作品ページの基本情報と遅延取得URLを解析する', () {
      const source = '''
        <html><head>
          <link rel="canonical" href="https://www.dlsite.com/maniax/work/=/product_id/RJ01234567.html">
          <meta itemprop="image" content="//img.dlsite.jp/work.jpg">
          <meta itemprop="price" content="1,100">
          <meta itemprop="ratingValue" content="4.75">
          <meta itemprop="ratingCount" content="32">
        </head><body>
          <h1 id="work_name"> テスト作品 </h1>
          <table id="work_maker"><tr><td><span class="maker_name">
            <a href="/maniax/circle/profile/=/maker_id/RG1.html">テストサークル</a>
          </span></td></tr></table>
          <table id="work_outline">
            <tr><th>販売日</th><td><a href="/maniax/new">2026年01月02日</a></td></tr>
            <tr><th>ファイル容量</th><td> 123 MB </td></tr>
          </table>
          <div itemprop="description" class="work_parts_container">
            <div class="work_parts type_text">
              <h3 class="work_parts_heading">作品概要</h3>
              <div class="work_parts_area"><p>画像の前</p>
                <a href="https://img.dlsite.jp/body-large.jpg">
                  <img data-src="//img.dlsite.jp/body.jpg" alt="本文サンプル" width="800" height="600">
                </a>
                <p>画像の後<br>2行目
                  <a href="https://example.com/credit">クレジット</a></p>
              </div>
            </div>
          </div>
          <div class="recommend_list" data-type="viewsales2"
            data-href="/maniax/load/recommend/example"></div>
          <script>var endpoint = 'https://www.dlsite.com/maniax/work/matome/ajax/=/product_id/RJ01234567.html';</script>
        </body></html>
      ''';

      final result = parser.parseWorkPage(source, pageUrl);
      final detail = result.detail;

      expect(detail.productId, 'RJ01234567');
      expect(detail.title, 'テスト作品');
      expect(detail.imageUrl.toString(), 'https://img.dlsite.jp/work.jpg');
      expect(detail.price, 1100);
      expect(detail.rating, 4.75);
      expect(detail.ratingCount, 32);
      expect(detail.circleName, 'テストサークル');
      expect(detail.workInfo, hasLength(2));
      expect(detail.workInfo.first.label, '販売日');
      expect(detail.descriptionSections.single.heading, '作品概要');
      final description = detail.descriptionSections.single;
      expect(description.text, contains('画像の前'));
      expect(description.text, contains('画像の後\n2行目'));
      expect(description.blocks, hasLength(3));
      expect(description.blocks[0], isA<DlsiteDescriptionTextBlock>());
      expect(description.blocks[1], isA<DlsiteDescriptionImageBlock>());
      expect(description.blocks[2], isA<DlsiteDescriptionTextBlock>());
      final bodyImage = description.blocks[1] as DlsiteDescriptionImageBlock;
      expect(bodyImage.imageUrl.toString(), 'https://img.dlsite.jp/body.jpg');
      expect(
        bodyImage.linkUrl.toString(),
        'https://img.dlsite.jp/body-large.jpg',
      );
      expect(bodyImage.alt, '本文サンプル');
      expect(bodyImage.aspectRatio, 4 / 3);
      expect(
        description.links.single.url.toString(),
        'https://example.com/credit',
      );
      expect(
        result.recommendationsUrl.toString(),
        'https://www.dlsite.com/maniax/load/recommend/example',
      );
      expect(
        result.relatedArticlesUrl.toString(),
        contains('/work/matome/ajax/'),
      );
    });

    test('遅延読み込み画像ではプレースホルダーよりsrcsetを優先する', () {
      const source = '''
        <html><body>
          <h1 id="work_name">遅延画像テスト</h1>
          <div data-product-id="RJ01234567"></div>
          <div itemprop="description" class="work_parts_container">
            <div class="work_parts type_image">
              <div class="work_parts_area">
                <a href="/large.jpg"><picture>
                  <source srcset="/small.webp 1x, /large.webp 2x">
                  <img src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yw="
                    data-srcset="/small.jpg 1x, /large.jpg 2x"
                    data-width="1600" data-height="900">
                </picture></a>
              </div>
            </div>
          </div>
        </body></html>
      ''';

      final detail = parser.parseWorkPage(source, pageUrl).detail;
      final image =
          detail.descriptionSections.single.blocks.single
              as DlsiteDescriptionImageBlock;

      expect(image.imageUrl.toString(), 'https://www.dlsite.com/large.jpg');
      expect(image.linkUrl.toString(), 'https://www.dlsite.com/large.jpg');
      expect(image.aspectRatio, closeTo(16 / 9, 0.001));
    });

    test('購入者おすすめHTMLを解析して重複を除外する', () {
      const source = '''
        <ul>
          <li data-prod="RJ111">
            <a class="work_thumb" href="/maniax/work/=/product_id/RJ111.html">
              <img-with-fallback :candidates="['//img.dlsite.jp/RJ111.webp','//img.dlsite.jp/RJ111.jpg']"></img-with-fallback>
            </a>
            <div class="work_category">ボイス・ASMR</div>
            <a class="work_name" title="おすすめ作品" href="/maniax/work/=/product_id/RJ111.html">おすすめ作品</a>
            <div class="maker_name"><a>サークル</a></div>
            <span class="work_price"><span class="work_price_base">770</span><span>円</span></span>
          </li>
          <li data-prod="RJ111"><a class="work_name" href="/duplicate">重複</a></li>
        </ul>
      ''';

      final result = parser.parseRecommendations(source, pageUrl);

      expect(result, hasLength(1));
      expect(result.single.productId, 'RJ111');
      expect(result.single.title, 'おすすめ作品');
      expect(
        result.single.imageUrl.toString(),
        'https://img.dlsite.jp/RJ111.webp',
      );
      expect(result.single.makerName, 'サークル');
      expect(result.single.category, 'ボイス・ASMR');
      expect(result.single.priceLabel, '770円');
    });

    test('関連まとめ記事を解析する', () {
      const source = '''
        <ul class="matome_box">
          <li class="matome_box_inner">
            <a href="https://ch.dlsite.com/matome/123"><img data-src="//media.dlsite.com/article.jpg" alt="記事"></a>
            <p class="matome_content_title"><a href="https://ch.dlsite.com/matome/123">関連する記事</a></p>
          </li>
        </ul>
      ''';

      final result = parser.parseRelatedArticles(source, pageUrl);

      expect(result, hasLength(1));
      expect(result.single.title, '関連する記事');
      expect(result.single.url.toString(), 'https://ch.dlsite.com/matome/123');
      expect(
        result.single.imageUrl.toString(),
        'https://media.dlsite.com/article.jpg',
      );
    });

    test('レビューJSONをコメントモデルへ変換する', () {
      final result = parser.parseReviews({
        'count': 12,
        'review_list': [
          {
            'member_review_id': '99',
            'workno': 'RJ01234567',
            'reviewer_id': 'REV1',
            'review_title': '良い作品',
            'review_text': '1行目\n2行目',
            'nick_name': '購入者',
            'entry_date': '2026-01-02 12:34:56',
            'rate_num': '50',
            'is_purchased': '1',
            'spoiler': '1',
            'good_review': '3',
          },
        ],
      }, pageUrl);

      expect(result.totalCount, 12);
      expect(result.reviews, hasLength(1));
      final review = result.reviews.single;
      expect(review.rating, 5);
      expect(review.isPurchased, isTrue);
      expect(review.containsSpoilers, isTrue);
      expect(review.helpfulCount, 3);
      expect(review.url.toString(), contains('/reviewlist/'));
    });

    test('作品ではないHTMLは解析エラーにする', () {
      expect(
        () => parser.parseWorkPage('<html></html>', pageUrl),
        throwsFormatException,
      );
    });
  });
}
