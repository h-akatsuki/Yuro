// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Child {

 String? get type; String? get title; List<Child>? get children; String? get hash; Work? get work; String? get workTitle; String? get mediaStreamUrl; String? get mediaDownloadUrl; int? get size;
/// Create a copy of Child
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChildCopyWith<Child> get copyWith => _$ChildCopyWithImpl<Child>(this as Child, _$identity);

  /// Serializes this Child to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Child&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.children, children)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.work, work) || other.work == work)&&(identical(other.workTitle, workTitle) || other.workTitle == workTitle)&&(identical(other.mediaStreamUrl, mediaStreamUrl) || other.mediaStreamUrl == mediaStreamUrl)&&(identical(other.mediaDownloadUrl, mediaDownloadUrl) || other.mediaDownloadUrl == mediaDownloadUrl)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(children),hash,work,workTitle,mediaStreamUrl,mediaDownloadUrl,size);

@override
String toString() {
  return 'Child(type: $type, title: $title, children: $children, hash: $hash, work: $work, workTitle: $workTitle, mediaStreamUrl: $mediaStreamUrl, mediaDownloadUrl: $mediaDownloadUrl, size: $size)';
}


}

/// @nodoc
abstract mixin class $ChildCopyWith<$Res>  {
  factory $ChildCopyWith(Child value, $Res Function(Child) _then) = _$ChildCopyWithImpl;
@useResult
$Res call({
 String? type, String? title, List<Child>? children, String? hash, Work? work, String? workTitle, String? mediaStreamUrl, String? mediaDownloadUrl, int? size
});


$WorkCopyWith<$Res>? get work;

}
/// @nodoc
class _$ChildCopyWithImpl<$Res>
    implements $ChildCopyWith<$Res> {
  _$ChildCopyWithImpl(this._self, this._then);

  final Child _self;
  final $Res Function(Child) _then;

/// Create a copy of Child
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? title = freezed,Object? children = freezed,Object? hash = freezed,Object? work = freezed,Object? workTitle = freezed,Object? mediaStreamUrl = freezed,Object? mediaDownloadUrl = freezed,Object? size = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,children: freezed == children ? _self.children : children // ignore: cast_nullable_to_non_nullable
as List<Child>?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,work: freezed == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as Work?,workTitle: freezed == workTitle ? _self.workTitle : workTitle // ignore: cast_nullable_to_non_nullable
as String?,mediaStreamUrl: freezed == mediaStreamUrl ? _self.mediaStreamUrl : mediaStreamUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaDownloadUrl: freezed == mediaDownloadUrl ? _self.mediaDownloadUrl : mediaDownloadUrl // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of Child
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkCopyWith<$Res>? get work {
    if (_self.work == null) {
    return null;
  }

  return $WorkCopyWith<$Res>(_self.work!, (value) {
    return _then(_self.copyWith(work: value));
  });
}
}


/// Adds pattern-matching-related methods to [Child].
extension ChildPatterns on Child {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Child value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Child() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Child value)  $default,){
final _that = this;
switch (_that) {
case _Child():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Child value)?  $default,){
final _that = this;
switch (_that) {
case _Child() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  String? title,  List<Child>? children,  String? hash,  Work? work,  String? workTitle,  String? mediaStreamUrl,  String? mediaDownloadUrl,  int? size)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Child() when $default != null:
return $default(_that.type,_that.title,_that.children,_that.hash,_that.work,_that.workTitle,_that.mediaStreamUrl,_that.mediaDownloadUrl,_that.size);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  String? title,  List<Child>? children,  String? hash,  Work? work,  String? workTitle,  String? mediaStreamUrl,  String? mediaDownloadUrl,  int? size)  $default,) {final _that = this;
switch (_that) {
case _Child():
return $default(_that.type,_that.title,_that.children,_that.hash,_that.work,_that.workTitle,_that.mediaStreamUrl,_that.mediaDownloadUrl,_that.size);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  String? title,  List<Child>? children,  String? hash,  Work? work,  String? workTitle,  String? mediaStreamUrl,  String? mediaDownloadUrl,  int? size)?  $default,) {final _that = this;
switch (_that) {
case _Child() when $default != null:
return $default(_that.type,_that.title,_that.children,_that.hash,_that.work,_that.workTitle,_that.mediaStreamUrl,_that.mediaDownloadUrl,_that.size);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Child implements Child {
   _Child({this.type, this.title, final  List<Child>? children, this.hash, this.work, this.workTitle, this.mediaStreamUrl, this.mediaDownloadUrl, this.size}): _children = children;
  factory _Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

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

@override final  String? hash;
@override final  Work? work;
@override final  String? workTitle;
@override final  String? mediaStreamUrl;
@override final  String? mediaDownloadUrl;
@override final  int? size;

/// Create a copy of Child
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChildCopyWith<_Child> get copyWith => __$ChildCopyWithImpl<_Child>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChildToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Child&&(identical(other.type, type) || other.type == type)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._children, _children)&&(identical(other.hash, hash) || other.hash == hash)&&(identical(other.work, work) || other.work == work)&&(identical(other.workTitle, workTitle) || other.workTitle == workTitle)&&(identical(other.mediaStreamUrl, mediaStreamUrl) || other.mediaStreamUrl == mediaStreamUrl)&&(identical(other.mediaDownloadUrl, mediaDownloadUrl) || other.mediaDownloadUrl == mediaDownloadUrl)&&(identical(other.size, size) || other.size == size));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,title,const DeepCollectionEquality().hash(_children),hash,work,workTitle,mediaStreamUrl,mediaDownloadUrl,size);

@override
String toString() {
  return 'Child(type: $type, title: $title, children: $children, hash: $hash, work: $work, workTitle: $workTitle, mediaStreamUrl: $mediaStreamUrl, mediaDownloadUrl: $mediaDownloadUrl, size: $size)';
}


}

/// @nodoc
abstract mixin class _$ChildCopyWith<$Res> implements $ChildCopyWith<$Res> {
  factory _$ChildCopyWith(_Child value, $Res Function(_Child) _then) = __$ChildCopyWithImpl;
@override @useResult
$Res call({
 String? type, String? title, List<Child>? children, String? hash, Work? work, String? workTitle, String? mediaStreamUrl, String? mediaDownloadUrl, int? size
});


@override $WorkCopyWith<$Res>? get work;

}
/// @nodoc
class __$ChildCopyWithImpl<$Res>
    implements _$ChildCopyWith<$Res> {
  __$ChildCopyWithImpl(this._self, this._then);

  final _Child _self;
  final $Res Function(_Child) _then;

/// Create a copy of Child
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? title = freezed,Object? children = freezed,Object? hash = freezed,Object? work = freezed,Object? workTitle = freezed,Object? mediaStreamUrl = freezed,Object? mediaDownloadUrl = freezed,Object? size = freezed,}) {
  return _then(_Child(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,children: freezed == children ? _self._children : children // ignore: cast_nullable_to_non_nullable
as List<Child>?,hash: freezed == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String?,work: freezed == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as Work?,workTitle: freezed == workTitle ? _self.workTitle : workTitle // ignore: cast_nullable_to_non_nullable
as String?,mediaStreamUrl: freezed == mediaStreamUrl ? _self.mediaStreamUrl : mediaStreamUrl // ignore: cast_nullable_to_non_nullable
as String?,mediaDownloadUrl: freezed == mediaDownloadUrl ? _self.mediaDownloadUrl : mediaDownloadUrl // ignore: cast_nullable_to_non_nullable
as String?,size: freezed == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of Child
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkCopyWith<$Res>? get work {
    if (_self.work == null) {
    return null;
  }

  return $WorkCopyWith<$Res>(_self.work!, (value) {
    return _then(_self.copyWith(work: value));
  });
}
}

// dart format on
