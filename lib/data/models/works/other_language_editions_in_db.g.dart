// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'other_language_editions_in_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OtherLanguageEditionsInDb _$OtherLanguageEditionsInDbFromJson(
  Map<String, dynamic> json,
) => _OtherLanguageEditionsInDb(
  id: (json['id'] as num?)?.toInt(),
  lang: json['lang'] as String?,
  title: json['title'] as String?,
  sourceId: json['source_id'] as String?,
  isOriginal: json['is_original'] as bool?,
  sourceType: json['source_type'] as String?,
);

Map<String, dynamic> _$OtherLanguageEditionsInDbToJson(
  _OtherLanguageEditionsInDb instance,
) => <String, dynamic>{
  'id': instance.id,
  'lang': instance.lang,
  'title': instance.title,
  'source_id': instance.sourceId,
  'is_original': instance.isOriginal,
  'source_type': instance.sourceType,
};
