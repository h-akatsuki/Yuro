import 'package:freezed_annotation/freezed_annotation.dart';

import 'pagination.dart';
import 'work.dart';

part 'works.freezed.dart';
part 'works.g.dart';

@freezed
abstract class Works with _$Works {
  factory Works({List<Work>? works, Pagination? pagination}) = _Works;

  factory Works.fromJson(Map<String, dynamic> json) => _$WorksFromJson(json);
}
