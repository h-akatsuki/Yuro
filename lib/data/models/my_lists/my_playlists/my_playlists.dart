import 'package:freezed_annotation/freezed_annotation.dart';

import 'pagination.dart';
import 'playlist.dart';

part 'my_playlists.freezed.dart';
part 'my_playlists.g.dart';

@freezed
abstract class MyPlaylists with _$MyPlaylists {
  factory MyPlaylists({List<Playlist>? playlists, Pagination? pagination}) =
      _MyPlaylists;

  factory MyPlaylists.fromJson(Map<String, dynamic> json) =>
      _$MyPlaylistsFromJson(json);
}
