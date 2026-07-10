// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'works.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Works _$WorksFromJson(Map<String, dynamic> json) => _Works(
  works: (json['works'] as List<dynamic>?)
      ?.map((e) => Work.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WorksToJson(_Works instance) => <String, dynamic>{
  'works': instance.works,
  'pagination': instance.pagination,
};
