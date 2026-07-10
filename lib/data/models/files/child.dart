import 'package:freezed_annotation/freezed_annotation.dart';

import 'work.dart';

part 'child.freezed.dart';
part 'child.g.dart';

@freezed
abstract class Child with _$Child {
  factory Child({
    String? type,
    String? title,
    List<Child>? children,
    String? hash,
    Work? work,
    String? workTitle,
    String? mediaStreamUrl,
    String? mediaDownloadUrl,
    int? size,
  }) = _Child;

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);
}
