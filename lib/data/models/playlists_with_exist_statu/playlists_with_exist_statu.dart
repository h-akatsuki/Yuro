import 'package:freezed_annotation/freezed_annotation.dart';

import 'pagination.dart';
import 'playlist.dart';

part 'playlists_with_exist_statu.freezed.dart';
part 'playlists_with_exist_statu.g.dart';

@freezed
abstract class PlaylistsWithExistStatu with _$PlaylistsWithExistStatu {
  factory PlaylistsWithExistStatu({
    List<Playlist>? playlists,
    Pagination? pagination,
  }) = _PlaylistsWithExistStatu;

  factory PlaylistsWithExistStatu.fromJson(Map<String, dynamic> json) =>
      _$PlaylistsWithExistStatuFromJson(json);
}
