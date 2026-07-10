// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_resp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthResp {

 User? get user; String? get token;
/// Create a copy of AuthResp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthRespCopyWith<AuthResp> get copyWith => _$AuthRespCopyWithImpl<AuthResp>(this as AuthResp, _$identity);

  /// Serializes this AuthResp to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResp&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'AuthResp(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class $AuthRespCopyWith<$Res>  {
  factory $AuthRespCopyWith(AuthResp value, $Res Function(AuthResp) _then) = _$AuthRespCopyWithImpl;
@useResult
$Res call({
 User? user, String? token
});


$UserCopyWith<$Res>? get user;

}
/// @nodoc
class _$AuthRespCopyWithImpl<$Res>
    implements $AuthRespCopyWith<$Res> {
  _$AuthRespCopyWithImpl(this._self, this._then);

  final AuthResp _self;
  final $Res Function(AuthResp) _then;

/// Create a copy of AuthResp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? token = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of AuthResp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResp].
extension AuthRespPatterns on AuthResp {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResp() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResp value)  $default,){
final _that = this;
switch (_that) {
case _AuthResp():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResp value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResp() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( User? user,  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResp() when $default != null:
return $default(_that.user,_that.token);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( User? user,  String? token)  $default,) {final _that = this;
switch (_that) {
case _AuthResp():
return $default(_that.user,_that.token);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( User? user,  String? token)?  $default,) {final _that = this;
switch (_that) {
case _AuthResp() when $default != null:
return $default(_that.user,_that.token);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResp implements AuthResp {
   _AuthResp({this.user, this.token});
  factory _AuthResp.fromJson(Map<String, dynamic> json) => _$AuthRespFromJson(json);

@override final  User? user;
@override final  String? token;

/// Create a copy of AuthResp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthRespCopyWith<_AuthResp> get copyWith => __$AuthRespCopyWithImpl<_AuthResp>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthRespToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResp&&(identical(other.user, user) || other.user == user)&&(identical(other.token, token) || other.token == token));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,token);

@override
String toString() {
  return 'AuthResp(user: $user, token: $token)';
}


}

/// @nodoc
abstract mixin class _$AuthRespCopyWith<$Res> implements $AuthRespCopyWith<$Res> {
  factory _$AuthRespCopyWith(_AuthResp value, $Res Function(_AuthResp) _then) = __$AuthRespCopyWithImpl;
@override @useResult
$Res call({
 User? user, String? token
});


@override $UserCopyWith<$Res>? get user;

}
/// @nodoc
class __$AuthRespCopyWithImpl<$Res>
    implements _$AuthRespCopyWith<$Res> {
  __$AuthRespCopyWithImpl(this._self, this._then);

  final _AuthResp _self;
  final $Res Function(_AuthResp) _then;

/// Create a copy of AuthResp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? token = freezed,}) {
  return _then(_AuthResp(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as User?,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of AuthResp
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
