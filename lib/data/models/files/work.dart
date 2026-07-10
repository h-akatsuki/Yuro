import 'package:freezed_annotation/freezed_annotation.dart';

part 'work.freezed.dart';
part 'work.g.dart';

@freezed
abstract class Work with _$Work {
  factory Work({
    int? id,
    @JsonKey(name: 'source_id') String? sourceId,
    @JsonKey(name: 'source_type') String? sourceType,
  }) = _Work;

  factory Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);
}
