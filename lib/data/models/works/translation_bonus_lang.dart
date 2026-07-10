import 'package:freezed_annotation/freezed_annotation.dart';

part 'translation_bonus_lang.freezed.dart';
part 'translation_bonus_lang.g.dart';

@freezed
abstract class TranslationBonusLang with _$TranslationBonusLang {
  factory TranslationBonusLang({
    int? price,
    String? status,
    @JsonKey(name: 'price_tax') int? priceTax,
    @JsonKey(name: 'child_count') int? childCount,
    @JsonKey(name: 'price_in_tax') int? priceInTax,
    @JsonKey(name: 'recipient_max') int? recipientMax,
    @JsonKey(name: 'recipient_available_count') int? recipientAvailableCount,
  }) = _TranslationBonusLang;

  factory TranslationBonusLang.fromJson(Map<String, dynamic> json) =>
      _$TranslationBonusLangFromJson(json);
}
