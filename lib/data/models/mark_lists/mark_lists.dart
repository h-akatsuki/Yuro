import 'package:freezed_annotation/freezed_annotation.dart';

import 'pagination.dart';
import 'playlist.dart';

part 'mark_lists.freezed.dart';
part 'mark_lists.g.dart';

@freezed
abstract class MarkLists with _$MarkLists {
  factory MarkLists({List<Playlist>? playlists, Pagination? pagination}) =
      _MarkLists;

  factory MarkLists.fromJson(Map<String, dynamic> json) =>
      _$MarkListsFromJson(json);
}
