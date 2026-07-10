// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'files.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Files {

 String? get type; String? get title; List<Child>? get children;
/// Create a copy of Files
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilesCopyWith<Files> get copyWith => _$FilesCopyWithImpl<Files>(this as Files, _$identity);

  /// Serializes this Files to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Files&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.children, children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(children));

@override
String toString() {
  return 'Files(type: $type, title: $title, children: $children)';
}


}

/// @nodoc
abstract mixin class $FilesCopyWith<$Res>  {
  factory $FilesCopyWith(Files value, $Res Function(Files) _then) = _$FilesCopyWithImpl;
@useResult
$Res call({
 String? type, String? title, List<Child>? children
});




}
/// @nodoc
class _$FilesCopyWithImpl<$Res>
    implements $FilesCopyWith<$Res> {
  _$FilesCopyWithImpl(this._self, this._then);

  final Files _self;
  final $Res Function(Files) _then;

/// Create a copy of Files
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? title = freezed,Object? children = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<Child>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Files].
extension FilesPatterns on Files {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Files value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Files() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Files value)  $default,){
final _that = this;
switch (_that) {
case _Files():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Files value)?  $default,){
final _that = this;
switch (_that) {
case _Files() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  String? title,  List<Child>? children)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Files() when $default != null:
return $default(_that.type,_that.title,_that.children);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  String? title,  List<Child>? children)  $default,) {final _that = this;
switch (_that) {
case _Files():
return $default(_that.type,_that.title,_that.children);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  String? title,  List<Child>? children)?  $default,) {final _that = this;
switch (_that) {
case _Files() when $default != null:
return $default(_that.type,_that.title,_that.children);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Files implements Files {
   _Files({this.type, this.title, final  List<Child>? children}): _children = children;
  factory _Files.fromJson(Map<String, dynamic> json) => _$FilesFromJson(json);

@override final  String? type;
@override final  String? title;
 final  List<Child>? _children;
@override List<Child>? get children {
  final value = _children;
  if (value == null) return null;
  if (_children is EqualUnmodifiableListView) return _children;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Files
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilesCopyWith<_Files> get copyWith => __$FilesCopyWithImpl<_Files>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Files&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._children, _children));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(_children));

@override
String toString() {
  return 'Files(type: $type, title: $title, children: $children)';
}


}

/// @nodoc
abstract mixin class _$FilesCopyWith<$Res> implements $FilesCopyWith<$Res> {
  factory _$FilesCopyWith(_Files value, $Res Function(_Files) _then) = __$FilesCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? title, List<Child>? children
});




}
/// @nodoc
class __$FilesCopyWithImpl<$Res>
    implements _$FilesCopyWith<$Res> {
  __$FilesCopyWithImpl(this._self, this._then);

  final _Files _self;
  final $Res Function(_Files) _then;

/// Create a copy of Files
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = freezed,Object? children = freezed,}) {
  return _then(_Files(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,children: freezed == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<Child>?,
  ));
}


}

// dart format on
