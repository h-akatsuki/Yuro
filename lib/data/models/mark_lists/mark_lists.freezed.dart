// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mark_lists.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MarkLists {

 List<Playlist>? get playlists; Pagination? get pagination;
/// Create a copy of MarkLists
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MarkListsCopyWith<MarkLists> get copyWith => _$MarkListsCopyWithImpl<MarkLists>(this as MarkLists, _$identity);

  /// Serializes this MarkLists to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MarkLists&&const DeepCollectionEquality().equals(other.playlists, playlists)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(playlists),pagination);

@override
String toString() {
  return 'MarkLists(playlists: $playlists, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $MarkListsCopyWith<$Res>  {
  factory $MarkListsCopyWith(MarkLists value, $Res Function(MarkLists) _then) = _$MarkListsCopyWithImpl;
@useResult
$Res call({
 List<Playlist>? playlists, Pagination? pagination
});


$PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$MarkListsCopyWithImpl<$Res>
    implements $MarkListsCopyWith<$Res> {
  _$MarkListsCopyWithImpl(this._self, this._then);

  final MarkLists _self;
  final $Res Function(MarkLists) _then;

/// Create a copy of MarkLists
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playlists = freezed,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
playlists: freezed == playlists ? _self.playlists : playlists // ignore: cast_nullable_to_non_nullable
as List<Playlist>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,
  ));
}
/// Create a copy of MarkLists
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


/// Adds pattern-matching-related methods to [MarkLists].
extension MarkListsPatterns on MarkLists {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MarkLists value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MarkLists() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MarkLists value)  $default,){
final _that = this;
switch (_that) {
case _MarkLists():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MarkLists value)?  $default,){
final _that = this;
switch (_that) {
case _MarkLists() when $default != null:
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
case _MarkLists() when $default != null:
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
case _MarkLists():
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
case _MarkLists() when $default != null:
return $default(_that.playlists,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MarkLists implements MarkLists {
   _MarkLists({final  List<Playlist>? playlists, this.pagination}): _playlists = playlists;
  factory _MarkLists.fromJson(Map<String, dynamic> json) => _$MarkListsFromJson(json);

 final  List<Playlist>? _playlists;
@override List<Playlist>? get playlists {
  final value = _playlists;
  if (value == null) return null;
  if (_playlists is EqualUnmodifiableListView) return _playlists;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Pagination? pagination;

/// Create a copy of MarkLists
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkListsCopyWith<_MarkLists> get copyWith => __$MarkListsCopyWithImpl<_MarkLists>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MarkListsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkLists&&const DeepCollectionEquality().equals(other._playlists, _playlists)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_playlists),pagination);

@override
String toString() {
  return 'MarkLists(playlists: $playlists, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$MarkListsCopyWith<$Res> implements $MarkListsCopyWith<$Res> {
  factory _$MarkListsCopyWith(_MarkLists value, $Res Function(_MarkLists) _then) = __$MarkListsCopyWithImpl;
@override @useResult
$Res call({
 List<Playlist>? playlists, Pagination? pagination
});


@override $PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$MarkListsCopyWithImpl<$Res>
    implements _$MarkListsCopyWith<$Res> {
  __$MarkListsCopyWithImpl(this._self, this._then);

  final _MarkLists _self;
  final $Res Function(_MarkLists) _then;

/// Create a copy of MarkLists
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playlists = freezed,Object? pagination = freezed,}) {
  return _then(_MarkLists(
playlists: freezed == playlists ? _self._playlists : playlists // ignore: cast_nullable_to_non_nullable
as List<Playlist>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,
  ));
}

/// Create a copy of MarkLists
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
