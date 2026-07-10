import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';
part 'playlist.g.dart';

@freezed
abstract class Playlist with _$Playlist {
  factory Playlist({
    String? id,
    @JsonKey(name: 'user_name') String? userName,
    int? privacy,
    String? locale,
    @JsonKey(name: 'playback_count') int? playbackCount,
    String? name,
    String? description,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'works_count') int? worksCount,
    @JsonKey(name: 'latestWorkID') dynamic latestWorkId,
    String? mainCoverUrl,
  }) = _Playlist;

  factory Playlist.fromJson(Map<String, dynamic> json) =>
      _$PlaylistFromJson(json);
}
