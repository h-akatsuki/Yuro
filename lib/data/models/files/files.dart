import 'package:freezed_annotation/freezed_annotation.dart';

import 'child.dart';

part 'files.freezed.dart';
part 'files.g.dart';

@freezed
abstract class Files with _$Files {
  factory Files({String? type, String? title, List<Child>? children}) = _Files;

  factory Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);
}
