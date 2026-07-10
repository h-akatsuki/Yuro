// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Child _$ChildFromJson(Map<String, dynamic> json) => _Child(
  type: json['type'] as String?,
  title: json['title'] as String?,
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
      .toList(),
  hash: json['hash'] as String?,
  work: json['work'] == null
      ? null
      : Work.fromJson(json['work'] as Map<String, dynamic>),
  workTitle: json['workTitle'] as String?,
  mediaStreamUrl: json['mediaStreamUrl'] as String?,
  mediaDownloadUrl: json['mediaDownloadUrl'] as String?,
  size: (json['size'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChildToJson(_Child instance) => <String, dynamic>{
  'type': instance.type,
  'title': instance.title,
  'children': instance.children,
  'hash': instance.hash,
  'work': instance.work,
  'workTitle': instance.workTitle,
  'mediaStreamUrl': instance.mediaStreamUrl,
  'mediaDownloadUrl': instance.mediaDownloadUrl,
  'size': instance.size,
};
