import 'package:freezed_annotation/freezed_annotation.dart';

import 'circle.dart';
import 'language_edition.dart';
import 'other_language_editions_in_db.dart';
import 'tag.dart';
import 'translation_info.dart';

part 'work.freezed.dart';
part 'work.g.dart';

@freezed
abstract class Work with _$Work {
  factory Work({
    int? id,
    String? title,
    @JsonKey(name: 'circle_id') int? circleId,
    String? name,
    bool? nsfw,
    String? release,
    @JsonKey(name: 'dl_count') int? dlCount,
    int? price,
    @JsonKey(name: 'review_count') int? reviewCount,
    @JsonKey(name: 'rate_count') int? rateCount,
    @JsonKey(name: 'rate_average_2dp') int? rateAverage2dp,
    @JsonKey(name: 'rate_count_detail') List<dynamic>? rateCountDetail,
    dynamic rank,
    @JsonKey(name: 'has_subtitle') bool? hasSubtitle,
    @JsonKey(name: 'create_date') String? createDate,
    List<dynamic>? vas,
    List<Tag>? tags,
    @JsonKey(name: 'language_editions') List<LanguageEdition>? languageEditions,
    @JsonKey(name: 'original_workno') String? originalWorkno,
    @JsonKey(name: 'other_language_editions_in_db')
    List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb,
    @JsonKey(name: 'translation_info') TranslationInfo? translationInfo,
    @JsonKey(name: 'work_attributes') String? workAttributes,
    @JsonKey(name: 'age_category_string') String? ageCategoryString,
    int? duration,
    @JsonKey(name: 'source_type') String? sourceType,
    @JsonKey(name: 'source_id') String? sourceId,
    @JsonKey(name: 'source_url') String? sourceUrl,
    dynamic userRating,
    Circle? circle,
    String? samCoverUrl,
    String? thumbnailCoverUrl,
    String? mainCoverUrl,
  }) = _Work;

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
}
