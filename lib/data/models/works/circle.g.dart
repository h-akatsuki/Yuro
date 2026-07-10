// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Circle _$CircleFromJson(Map<String, dynamic> json) => _Circle(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  sourceId: json['source_id'] as String?,
  sourceType: json['source_type'] as String?,
);

Map<String, dynamic> _$CircleToJson(_Circle instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'source_id': instance.sourceId,
  'source_type': instance.sourceType,
};
