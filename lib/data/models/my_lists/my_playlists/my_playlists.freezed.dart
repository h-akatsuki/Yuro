// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_playlists.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MyPlaylists {

 List<Playlist>? get playlists; Pagination? get pagination;
/// Create a copy of MyPlaylists
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyPlaylistsCopyWith<MyPlaylists> get copyWith => _$MyPlaylistsCopyWithImpl<MyPlaylists>(this as MyPlaylists, _$identity);

  /// Serializes this MyPlaylists to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyPlaylists&&const DeepCollectionEquality().equals(other.playlists, playlists)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(playlists),pagination);

@override
String toString() {
  return 'MyPlaylists(playlists: $playlists, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $MyPlaylistsCopyWith<$Res>  {
  factory $MyPlaylistsCopyWith(MyPlaylists value, $Res Function(MyPlaylists) _then) = _$MyPlaylistsCopyWithImpl;
@useResult
$Res call({
 List<Playlist>? playlists, Pagination? pagination
});


$PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$MyPlaylistsCopyWithImpl<$Res>
    implements $MyPlaylistsCopyWith<$Res> {
  _$MyPlaylistsCopyWithImpl(this._self, this._then);

  final MyPlaylists _self;
  final $Res Function(MyPlaylists) _then;

/// Create a copy of MyPlaylists
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playlists = freezed,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
playlists: freezed == playlists ? _self.playlists : playlists // ignore: cast_nullable_to_non_nullable
as List<Playlist>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,
  ));
}
/// Create a copy of MyPlaylists
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}


/// Adds pattern-matching-related methods to [MyPlaylists].
extension MyPlaylistsPatterns on MyPlaylists {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyPlaylists value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyPlaylists() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyPlaylists value)  $default,){
final _that = this;
switch (_that) {
case _MyPlaylists():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyPlaylists value)?  $default,){
final _that = this;
switch (_that) {
case _MyPlaylists() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Playlist>? playlists,  Pagination? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyPlaylists() when $default != null:
return $default(_that.playlists,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Playlist>? playlists,  Pagination? pagination)  $default,) {final _that = this;
switch (_that) {
case _MyPlaylists():
return $default(_that.playlists,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Playlist>? playlists,  Pagination? pagination)?  $default,) {final _that = this;
switch (_that) {
case _MyPlaylists() when $default != null:
return $default(_that.playlists,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MyPlaylists implements MyPlaylists {
   _MyPlaylists({final  List<Playlist>? playlists, this.pagination}): _playlists = playlists;
  factory _MyPlaylists.fromJson(Map<String, dynamic> json) => _$MyPlaylistsFromJson(json);

 final  List<Playlist>? _playlists;
@override List<Playlist>? get playlists {
  final value = _playlists;
  if (value == null) return null;
  if (_playlists is EqualUnmodifiableListView) return _playlists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Pagination? pagination;

/// Create a copy of MyPlaylists
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyPlaylistsCopyWith<_MyPlaylists> get copyWith => __$MyPlaylistsCopyWithImpl<_MyPlaylists>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MyPlaylistsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyPlaylists&&const DeepCollectionEquality().equals(other._playlists, _playlists)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_playlists),pagination);

@override
String toString() {
  return 'MyPlaylists(playlists: $playlists, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$MyPlaylistsCopyWith<$Res> implements $MyPlaylistsCopyWith<$Res> {
  factory _$MyPlaylistsCopyWith(_MyPlaylists value, $Res Function(_MyPlaylists) _then) = __$MyPlaylistsCopyWithImpl;
@override @useResult
$Res call({
 List<Playlist>? playlists, Pagination? pagination
});


@override $PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$MyPlaylistsCopyWithImpl<$Res>
    implements _$MyPlaylistsCopyWith<$Res> {
  __$MyPlaylistsCopyWithImpl(this._self, this._then);

  final _MyPlaylists _self;
  final $Res Function(_MyPlaylists) _then;

/// Create a copy of MyPlaylists
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playlists = freezed,Object? pagination = freezed,}) {
  return _then(_MyPlaylists(
playlists: freezed == playlists ? _self._playlists : playlists // ignore: cast_nullable_to_non_nullable
as List<Playlist>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,
  ));
}

/// Create a copy of MyPlaylists
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaginationCopyWith<$Res>? get pagination {
    if (_self.pagination == null) {
    return null;
  }

  return $PaginationCopyWith<$Res>(_self.pagination!, (value) {
    return _then(_self.copyWith(pagination: value));
  });
}
}

// dart format on
