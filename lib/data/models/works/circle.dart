import 'package:freezed_annotation/freezed_annotation.dart';

part 'circle.freezed.dart';
part 'circle.g.dart';

@freezed
abstract class Circle with _$Circle {
  factory Circle({
    int? id,
    String? name,
    @JsonKey(name: 'source_id') String? sourceId,
    @JsonKey(name: 'source_type') String? sourceType,
  }) = _Circle;

  factory Circle.fromJson(Map<String, dynamic> json) => _$CircleFromJson(json);
}
