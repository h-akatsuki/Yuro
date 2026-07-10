// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'works.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Works {

 List<Work>? get works; Pagination? get pagination;
/// Create a copy of Works
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorksCopyWith<Works> get copyWith => _$WorksCopyWithImpl<Works>(this as Works, _$identity);

  /// Serializes this Works to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Works&&const DeepCollectionEquality().equals(other.works, works)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(works),pagination);

@override
String toString() {
  return 'Works(works: $works, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $WorksCopyWith<$Res>  {
  factory $WorksCopyWith(Works value, $Res Function(Works) _then) = _$WorksCopyWithImpl;
@useResult
$Res call({
 List<Work>? works, Pagination? pagination
});


$PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class _$WorksCopyWithImpl<$Res>
    implements $WorksCopyWith<$Res> {
  _$WorksCopyWithImpl(this._self, this._then);

  final Works _self;
  final $Res Function(Works) _then;

/// Create a copy of Works
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? works = freezed,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
works: freezed == works ? _self.works : works // ignore: cast_nullable_to_non_nullable
as List<Work>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,
  ));
}
/// Create a copy of Works
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


/// Adds pattern-matching-related methods to [Works].
extension WorksPatterns on Works {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Works value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Works() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Works value)  $default,){
final _that = this;
switch (_that) {
case _Works():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Works value)?  $default,){
final _that = this;
switch (_that) {
case _Works() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Work>? works,  Pagination? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Works() when $default != null:
return $default(_that.works,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Work>? works,  Pagination? pagination)  $default,) {final _that = this;
switch (_that) {
case _Works():
return $default(_that.works,_that.pagination);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Work>? works,  Pagination? pagination)?  $default,) {final _that = this;
switch (_that) {
case _Works() when $default != null:
return $default(_that.works,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Works implements Works {
   _Works({final  List<Work>? works, this.pagination}): _works = works;
  factory _Works.fromJson(Map<String, dynamic> json) => _$WorksFromJson(json);

 final  List<Work>? _works;
@override List<Work>? get works {
  final value = _works;
  if (value == null) return null;
  if (_works is EqualUnmodifiableListView) return _works;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Pagination? pagination;

/// Create a copy of Works
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorksCopyWith<_Works> get copyWith => __$WorksCopyWithImpl<_Works>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorksToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Works&&const DeepCollectionEquality().equals(other._works, _works)&&(identical(other.pagination, pagination) || other.pagination == pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_works),pagination);

@override
String toString() {
  return 'Works(works: $works, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$WorksCopyWith<$Res> implements $WorksCopyWith<$Res> {
  factory _$WorksCopyWith(_Works value, $Res Function(_Works) _then) = __$WorksCopyWithImpl;
@override @useResult
$Res call({
 List<Work>? works, Pagination? pagination
});


@override $PaginationCopyWith<$Res>? get pagination;

}
/// @nodoc
class __$WorksCopyWithImpl<$Res>
    implements _$WorksCopyWith<$Res> {
  __$WorksCopyWithImpl(this._self, this._then);

  final _Works _self;
  final $Res Function(_Works) _then;

/// Create a copy of Works
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? works = freezed,Object? pagination = freezed,}) {
  return _then(_Works(
works: freezed == works ? _self._works : works // ignore: cast_nullable_to_non_nullable
as List<Work>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Pagination?,
  ));
}

/// Create a copy of Works
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
