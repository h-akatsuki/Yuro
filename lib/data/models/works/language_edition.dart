import 'package:freezed_annotation/freezed_annotation.dart';

part 'language_edition.freezed.dart';
part 'language_edition.g.dart';

@freezed
abstract class LanguageEdition with _$LanguageEdition {
  factory LanguageEdition({
    String? lang,
    String? label,
    String? workno,
    @JsonKey(name: 'edition_id') int? editionId,
    @JsonKey(name: 'edition_type') String? editionType,
    @JsonKey(name: 'display_order') int? displayOrder,
  }) = _LanguageEdition;

  factory LanguageEdition.fromJson(Map<String, dynamic> json) =>
      _$LanguageEditionFromJson(json);
}
