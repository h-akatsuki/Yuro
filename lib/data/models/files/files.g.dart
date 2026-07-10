// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Files _$FilesFromJson(Map<String, dynamic> json) => _Files(
  type: json['type'] as String?,
  title: json['title'] as String?,
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => Child.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FilesToJson(_Files instance) => <String, dynamic>{
  'type': instance.type,
  'title': instance.title,
  'children': instance.children,
};
