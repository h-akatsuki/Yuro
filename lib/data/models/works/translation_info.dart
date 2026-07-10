import 'package:freezed_annotation/freezed_annotation.dart';
import 'translation_bonus_lang.dart';

part 'translation_info.freezed.dart';
part 'translation_info.g.dart';

@freezed
abstract class TranslationInfo with _$TranslationInfo {
  factory TranslationInfo({
    String? lang,
    @JsonKey(name: 'is_child') bool? isChild,
    @JsonKey(name: 'is_parent') bool? isParent,
    @JsonKey(name: 'is_original') bool? isOriginal,
    @JsonKey(name: 'is_volunteer') bool? isVolunteer,
    @JsonKey(name: 'child_worknos') List<dynamic>? childWorknos,
    @JsonKey(name: 'parent_workno') String? parentWorkno,
    @JsonKey(name: 'original_workno') String? originalWorkno,
    @JsonKey(name: 'is_translation_agree') bool? isTranslationAgree,
    @JsonKey(
      name: 'translation_bonus_langs',
      fromJson: _translationBonusLangsFromJson,
      toJson: _translationBonusLangsToJson,
    )
    Map<String, TranslationBonusLang>? translationBonusLangs,
    @JsonKey(name: 'is_translation_bonus_child') bool? isTranslationBonusChild,
    @JsonKey(name: 'production_trade_price_rate') int? productionTradePriceRate,
  }) = _TranslationInfo;

  factory TranslationInfo.fromJson(Map<String, dynamic> json) =>
      _$TranslationInfoFromJson(json);
}

Map<String, TranslationBonusLang>? _translationBonusLangsFromJson(
  dynamic json,
) {
  if (json == null) return null;
  if (json is List && json.isEmpty) return {};

  if (json is Map<String, dynamic>) {
    return json.map(
      (key, value) => MapEntry(
        key,
        TranslationBonusLang.fromJson(value as Map<String, dynamic>),
      ),
    );
  }

  return {};
}

dynamic _translationBonusLangsToJson(Map<String, TranslationBonusLang>? map) {
  if (map == null) return null;
  if (map.isEmpty) return [];

  return map.map((key, value) => MapEntry(key, value.toJson()));
}
