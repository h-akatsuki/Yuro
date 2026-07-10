// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResp _$AuthRespFromJson(Map<String, dynamic> json) => _AuthResp(
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
  token: json['token'] as String?,
);

Map<String, dynamic> _$AuthRespToJson(_AuthResp instance) => <String, dynamic>{
  'user': instance.user,
  'token': instance.token,
};
