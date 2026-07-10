import 'package:freezed_annotation/freezed_annotation.dart';

part 'zh_cn.freezed.dart';
part 'zh_cn.g.dart';

@freezed
abstract class ZhCn with _$ZhCn {
  factory ZhCn({String? name, List<dynamic>? history}) = _ZhCn;

  factory ZhCn.fromJson(Map<String, dynamic> json) => _$ZhCnFromJson(json);
}
