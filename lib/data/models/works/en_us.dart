import 'package:freezed_annotation/freezed_annotation.dart';

part 'en_us.freezed.dart';
part 'en_us.g.dart';

@freezed
abstract class EnUs with _$EnUs {
  factory EnUs({String? name, List<dynamic>? history}) = _EnUs;

  factory EnUs.fromJson(Map<String, dynamic> json) => _$EnUsFromJson(json);
}
