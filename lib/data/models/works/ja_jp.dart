import 'package:freezed_annotation/freezed_annotation.dart';

part 'ja_jp.freezed.dart';
part 'ja_jp.g.dart';

@freezed
abstract class JaJp with _$JaJp {
  factory JaJp({String? name}) = _JaJp;

  factory JaJp.fromJson(Map<String, dynamic> json) => _$JaJpFromJson(json);
}
