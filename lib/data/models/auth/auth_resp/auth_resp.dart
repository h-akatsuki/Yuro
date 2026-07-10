import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'auth_resp.freezed.dart';
part 'auth_resp.g.dart';

@freezed
abstract class AuthResp with _$AuthResp {
  factory AuthResp({User? user, String? token}) = _AuthResp;

  factory AuthResp.fromJson(Map<String, dynamic> json) =>
      _$AuthRespFromJson(json);
}
