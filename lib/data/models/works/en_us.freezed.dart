// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'en_us.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EnUs {

 String? get name; List<dynamic>? get history;
/// Create a copy of EnUs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EnUsCopyWith<EnUs> get copyWith => _$EnUsCopyWithImpl<EnUs>(this as EnUs, _$identity);

  /// Serializes this EnUs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EnUs&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.history, history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(history));

@override
String toString() {
  return 'EnUs(name: $name, history: $history)';
}


}

/// @nodoc
abstract mixin class $EnUsCopyWith<$Res>  {
  factory $EnUsCopyWith(EnUs value, $Res Function(EnUs) _then) = _$EnUsCopyWithImpl;
@useResult
$Res call({
 String? name, List<dynamic>? history
});




}
/// @nodoc
class _$EnUsCopyWithImpl<$Res>
    implements $EnUsCopyWith<$Res> {
  _$EnUsCopyWithImpl(this._self, this._then);

  final EnUs _self;
  final $Res Function(EnUs) _then;

/// Create a copy of EnUs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? history = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EnUs].
extension EnUsPatterns on EnUs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EnUs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EnUs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EnUs value)  $default,){
final _that = this;
switch (_that) {
case _EnUs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EnUs value)?  $default,){
final _that = this;
switch (_that) {
case _EnUs() when $default != null:
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
case _EnUs() when $default != null:
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
case _EnUs():
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
case _EnUs() when $default != null:
return $default(_that.name,_that.history);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EnUs implements EnUs {
   _EnUs({this.name, final  List<dynamic>? history}): _history = history;
  factory _EnUs.fromJson(Map<String, dynamic> json) => _$EnUsFromJson(json);

@override final  String? name;
 final  List<dynamic>? _history;
@override List<dynamic>? get history {
  final value = _history;
  if (value == null) return null;
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EnUs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EnUsCopyWith<_EnUs> get copyWith => __$EnUsCopyWithImpl<_EnUs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EnUsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EnUs&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._history, _history));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_history));

@override
String toString() {
  return 'EnUs(name: $name, history: $history)';
}


}

/// @nodoc
abstract mixin class _$EnUsCopyWith<$Res> implements $EnUsCopyWith<$Res> {
  factory _$EnUsCopyWith(_EnUs value, $Res Function(_EnUs) _then) = __$EnUsCopyWithImpl;
@override @useResult
$Res call({
 String? name, List<dynamic>? history
});




}
/// @nodoc
class __$EnUsCopyWithImpl<$Res>
    implements _$EnUsCopyWith<$Res> {
  __$EnUsCopyWithImpl(this._self, this._then);

  final _EnUs _self;
  final $Res Function(_EnUs) _then;

/// Create a copy of EnUs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? history = freezed,}) {
  return _then(_EnUs(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,history: freezed == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,
  ));
}


}

// dart format on
