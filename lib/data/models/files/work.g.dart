// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Work _$WorkFromJson(Map<String, dynamic> json) => _Work(
  id: (json['id'] as num?)?.toInt(),
  sourceId: json['source_id'] as String?,
  sourceType: json['source_type'] as String?,
);

Map<String, dynamic> _$WorkToJson(_Work instance) => <String, dynamic>{
  'id': instance.id,
  'source_id': instance.sourceId,
  'source_type': instance.sourceType,
};
