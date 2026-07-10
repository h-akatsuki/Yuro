// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'zh_cn.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ZhCn {

 String? get name; List<dynamic>? get history;
/// Create a copy of ZhCn
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ZhCnCopyWith<ZhCn> get copyWith => _$ZhCnCopyWithImpl<ZhCn>(this as ZhCn, _$identity);

  /// Serializes this ZhCn to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ZhCn&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.history, history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(history));

@override
String toString() {
  return 'ZhCn(name: $name, history: $history)';
}


}

/// @nodoc
abstract mixin class $ZhCnCopyWith<$Res>  {
  factory $ZhCnCopyWith(ZhCn value, $Res Function(ZhCn) _then) = _$ZhCnCopyWithImpl;
@useResult
$Res call({
 String? name, List<dynamic>? history
});




}
/// @nodoc
class _$ZhCnCopyWithImpl<$Res>
    implements $ZhCnCopyWith<$Res> {
  _$ZhCnCopyWithImpl(this._self, this._then);

  final ZhCn _self;
  final $Res Function(ZhCn) _then;

/// Create a copy of ZhCn
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? history = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ZhCn].
extension ZhCnPatterns on ZhCn {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ZhCn value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ZhCn() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ZhCn value)  $default,){
final _that = this;
switch (_that) {
case _ZhCn():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ZhCn value)?  $default,){
final _that = this;
switch (_that) {
case _ZhCn() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  List<dynamic>? history)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ZhCn() when $default != null:
return $default(_that.name,_that.history);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  List<dynamic>? history)  $default,) {final _that = this;
switch (_that) {
case _ZhCn():
return $default(_that.name,_that.history);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  List<dynamic>? history)?  $default,) {final _that = this;
switch (_that) {
case _ZhCn() when $default != null:
return $default(_that.name,_that.history);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ZhCn implements ZhCn {
   _ZhCn({this.name, final  List<dynamic>? history}): _history = history;
  factory _ZhCn.fromJson(Map<String, dynamic> json) => _$ZhCnFromJson(json);

@override final  String? name;
 final  List<dynamic>? _history;
@override List<dynamic>? get history {
  final value = _history;
  if (value == null) return null;
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ZhCn
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ZhCnCopyWith<_ZhCn> get copyWith => __$ZhCnCopyWithImpl<_ZhCn>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ZhCnToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ZhCn&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._history, _history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'ZhCn(name: $name, history: $history)';
}


}

/// @nodoc
abstract mixin class _$ZhCnCopyWith<$Res> implements $ZhCnCopyWith<$Res> {
  factory _$ZhCnCopyWith(_ZhCn value, $Res Function(_ZhCn) _then) = __$ZhCnCopyWithImpl;
@override @useResult
$Res call({
 String? name, List<dynamic>? history
});




}
/// @nodoc
class __$ZhCnCopyWithImpl<$Res>
    implements _$ZhCnCopyWith<$Res> {
  __$ZhCnCopyWithImpl(this._self, this._then);

  final _ZhCn _self;
  final $Res Function(_ZhCn) _then;

/// Create a copy of ZhCn
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? history = freezed,}) {
  return _then(_ZhCn(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}

// dart format on
