// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_edition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LanguageEdition _$LanguageEditionFromJson(Map<String, dynamic> json) =>
    _LanguageEdition(
      lang: json['lang'] as String?,
      label: json['label'] as String?,
      workno: json['workno'] as String?,
      editionId: (json['edition_id'] as num?)?.toInt(),
      editionType: json['edition_type'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LanguageEditionToJson(_LanguageEdition instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'label': instance.label,
      'workno': instance.workno,
      'edition_id': instance.editionId,
      'edition_type': instance.editionType,
      'display_order': instance.displayOrder,
    };
