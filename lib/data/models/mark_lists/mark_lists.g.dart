// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_lists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarkLists _$MarkListsFromJson(Map<String, dynamic> json) => _MarkLists(
  playlists: (json['playlists'] as List<dynamic>?)
      ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MarkListsToJson(_MarkLists instance) =>
    <String, dynamic>{
      'playlists': instance.playlists,
      'pagination': instance.pagination,
    };
