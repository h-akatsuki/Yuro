import 'package:asmrapp/data/models/dlsite/dlsite_work_detail.dart';
import 'package:asmrapp/data/services/dlsite_parser.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:dio/dio.dart';

class DlsiteService {
  static const _headers = <String, String>{
    'Accept-Language': 'ja-JP,ja;q=0.9',
    'Cookie': 'adultchecked=1',
    'User-Agent':
        'Mozilla/5.0 (Linux; Android 15) AppleWebKit/537.36 '
        'Chrome/126 Mobile Safari/537.36',
  };

  final Dio _dio;
  final DlsiteParser _parser;

  DlsiteService({Dio? dio, DlsiteParser? parser})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 20),
              followRedirects: true,
              headers: _headers,
            ),
          ),
      _parser = parser ?? DlsiteParser();

  Future<DlsiteWorkDetail> getWorkDetail(
    Uri pageUrl, {
    CancelToken? cancelToken,
  }) async {
    final pageSource = await _getText(pageUrl, cancelToken: cancelToken);
    final pageData = _parser.parseWorkPage(pageSource, pageUrl);

    final results = await Future.wait<Object>([
      _loadRecommendations(pageData.recommendationsUrl, cancelToken),
      _loadArticles(pageData.relatedArticlesUrl, cancelToken),
      _loadReviews(pageData.detail, cancelToken),
    ]);

    final reviewsData = results[2] as DlsiteReviewsData;
    return pageData.detail.copyWith(
      recommendations: results[0] as List<DlsiteRecommendation>,
      relatedArticles: results[1] as List<DlsiteArticle>,
      reviews: reviewsData.reviews,
      reviewCount: reviewsData.totalCount,
    );
  }

  Future<List<DlsiteRecommendation>> _loadRecommendations(
    Uri? url,
    CancelToken? cancelToken,
  ) async {
    if (url == null) return const [];
    try {
      final source = await _getText(url, cancelToken: cancelToken);
      return _parser.parseRecommendations(source, url).take(12).toList();
    } catch (error, stackTrace) {
      if (_isCancellation(error)) {
        rethrow;
      }
      AppLogger.error('DLsiteのおすすめ作品取得に失敗', error, stackTrace);
      return const [];
    }
  }

  Future<List<DlsiteArticle>> _loadArticles(
    Uri? url,
    CancelToken? cancelToken,
  ) async {
    if (url == null) return const [];
    try {
      final source = await _getText(url, cancelToken: cancelToken);
      return _parser.parseRelatedArticles(source, url).take(8).toList();
    } catch (error, stackTrace) {
      if (_isCancellation(error)) {
        rethrow;
      }
      AppLogger.error('DLsiteの関連まとめ取得に失敗', error, stackTrace);
      return const [];
    }
  }

  Future<DlsiteReviewsData> _loadReviews(
    DlsiteWorkDetail detail,
    CancelToken? cancelToken,
  ) async {
    final url = detail.pageUrl.resolve(
      '/maniax/api/review?product_id=${detail.productId}&limit=6',
    );
    try {
      final response = await _dio.get<dynamic>(
        url.toString(),
        cancelToken: cancelToken,
      );
      final data = response.data;
      if (data is! Map) {
        return const DlsiteReviewsData(reviews: [], totalCount: 0);
      }
      return _parser.parseReviews(
        Map<String, dynamic>.from(data),
        detail.pageUrl,
      );
    } catch (error, stackTrace) {
      if (_isCancellation(error)) {
        rethrow;
      }
      AppLogger.error('DLsiteのレビュー取得に失敗', error, stackTrace);
      return const DlsiteReviewsData(reviews: [], totalCount: 0);
    }
  }

  Future<String> _getText(Uri url, {CancelToken? cancelToken}) async {
    final response = await _dio.get<String>(
      url.toString(),
      cancelToken: cancelToken,
      options: Options(responseType: ResponseType.plain),
    );
    final source = response.data;
    if (source == null || source.trim().isEmpty) {
      throw const FormatException('DLsiteから空の応答が返されました');
    }
    return source;
  }

  bool _isCancellation(Object error) {
    return error is DioException && error.type == DioExceptionType.cancel;
  }
}
