// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  loggedIn: json['loggedIn'] as bool?,
  name: json['name'] as String?,
  group: json['group'] as String?,
  email: json['email'],
  recommenderUuid: json['recommenderUuid'] as String?,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'loggedIn': instance.loggedIn,
  'name': instance.name,
  'group': instance.group,
  'email': instance.email,
  'recommenderUuid': instance.recommenderUuid,
};
