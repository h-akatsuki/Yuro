// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_with_exist_statu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaylistsWithExistStatu _$PlaylistsWithExistStatuFromJson(
  Map<String, dynamic> json,
) => _PlaylistsWithExistStatu(
  playlists: (json['playlists'] as List<dynamic>?)
      ?.map((e) => Playlist.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PlaylistsWithExistStatuToJson(
  _PlaylistsWithExistStatu instance,
) => <String, dynamic>{
  'playlists': instance.playlists,
  'pagination': instance.pagination,
};
