// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_playlists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyPlaylists _$MyPlaylistsFromJson(Map<String, dynamic> json) => _MyPlaylists(
  playlists: (json['playlists'] as List<dynamic>?)
      ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MyPlaylistsToJson(_MyPlaylists instance) =>
    <String, dynamic>{
      'playlists': instance.playlists,
      'pagination': instance.pagination,
    };
