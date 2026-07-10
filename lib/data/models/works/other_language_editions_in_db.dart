import 'package:freezed_annotation/freezed_annotation.dart';

part 'other_language_editions_in_db.freezed.dart';
part 'other_language_editions_in_db.g.dart';

@freezed
abstract class OtherLanguageEditionsInDb with _$OtherLanguageEditionsInDb {
  factory OtherLanguageEditionsInDb({
    int? id,
    String? lang,
    String? title,
    @JsonKey(name: 'source_id') String? sourceId,
    @JsonKey(name: 'is_original') bool? isOriginal,
    @JsonKey(name: 'source_type') String? sourceType,
  }) = _OtherLanguageEditionsInDb;

  factory OtherLanguageEditionsInDb.fromJson(Map<String, dynamic> json) =>
      _$OtherLanguageEditionsInDbFromJson(json);
}
