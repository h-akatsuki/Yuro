// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'other_language_editions_in_db.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtherLanguageEditionsInDb {

 int? get id; String? get lang; String? get title;@JsonKey(name: 'source_id') String? get sourceId;@JsonKey(name: 'is_original') bool? get isOriginal;@JsonKey(name: 'source_type') String? get sourceType;
/// Create a copy of OtherLanguageEditionsInDb
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtherLanguageEditionsInDbCopyWith<OtherLanguageEditionsInDb> get copyWith => _$OtherLanguageEditionsInDbCopyWithImpl<OtherLanguageEditionsInDb>(this as OtherLanguageEditionsInDb, _$identity);

  /// Serializes this OtherLanguageEditionsInDb to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtherLanguageEditionsInDb&&(identical(other.id, id) || other.id == id)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.title, title) || other.title == title)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.isOriginal, isOriginal) || other.isOriginal == isOriginal)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lang,title,sourceId,isOriginal,sourceType);

@override
String toString() {
  return 'OtherLanguageEditionsInDb(id: $id, lang: $lang, title: $title, sourceId: $sourceId, isOriginal: $isOriginal, sourceType: $sourceType)';
}


}

/// @nodoc
abstract mixin class $OtherLanguageEditionsInDbCopyWith<$Res>  {
  factory $OtherLanguageEditionsInDbCopyWith(OtherLanguageEditionsInDb value, $Res Function(OtherLanguageEditionsInDb) _then) = _$OtherLanguageEditionsInDbCopyWithImpl;
@useResult
$Res call({
 int? id, String? lang, String? title,@JsonKey(name: 'source_id') String? sourceId,@JsonKey(name: 'is_original') bool? isOriginal,@JsonKey(name: 'source_type') String? sourceType
});




}
/// @nodoc
class _$OtherLanguageEditionsInDbCopyWithImpl<$Res>
    implements $OtherLanguageEditionsInDbCopyWith<$Res> {
  _$OtherLanguageEditionsInDbCopyWithImpl(this._self, this._then);

  final OtherLanguageEditionsInDb _self;
  final $Res Function(OtherLanguageEditionsInDb) _then;

/// Create a copy of OtherLanguageEditionsInDb
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? lang = freezed,Object? title = freezed,Object? sourceId = freezed,Object? isOriginal = freezed,Object? sourceType = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,isOriginal: freezed == isOriginal ? _self.isOriginal : isOriginal // ignore: cast_nullable_to_non_nullable
as bool?,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtherLanguageEditionsInDb].
extension OtherLanguageEditionsInDbPatterns on OtherLanguageEditionsInDb {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtherLanguageEditionsInDb value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtherLanguageEditionsInDb() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtherLanguageEditionsInDb value)  $default,){
final _that = this;
switch (_that) {
case _OtherLanguageEditionsInDb():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtherLanguageEditionsInDb value)?  $default,){
final _that = this;
switch (_that) {
case _OtherLanguageEditionsInDb() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? lang,  String? title, @JsonKey(name: 'source_id')  String? sourceId, @JsonKey(name: 'is_original')  bool? isOriginal, @JsonKey(name: 'source_type')  String? sourceType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtherLanguageEditionsInDb() when $default != null:
return $default(_that.id,_that.lang,_that.title,_that.sourceId,_that.isOriginal,_that.sourceType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? lang,  String? title, @JsonKey(name: 'source_id')  String? sourceId, @JsonKey(name: 'is_original')  bool? isOriginal, @JsonKey(name: 'source_type')  String? sourceType)  $default,) {final _that = this;
switch (_that) {
case _OtherLanguageEditionsInDb():
return $default(_that.id,_that.lang,_that.title,_that.sourceId,_that.isOriginal,_that.sourceType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? lang,  String? title, @JsonKey(name: 'source_id')  String? sourceId, @JsonKey(name: 'is_original')  bool? isOriginal, @JsonKey(name: 'source_type')  String? sourceType)?  $default,) {final _that = this;
switch (_that) {
case _OtherLanguageEditionsInDb() when $default != null:
return $default(_that.id,_that.lang,_that.title,_that.sourceId,_that.isOriginal,_that.sourceType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtherLanguageEditionsInDb implements OtherLanguageEditionsInDb {
   _OtherLanguageEditionsInDb({this.id, this.lang, this.title, @JsonKey(name: 'source_id') this.sourceId, @JsonKey(name: 'is_original') this.isOriginal, @JsonKey(name: 'source_type') this.sourceType});
  factory _OtherLanguageEditionsInDb.fromJson(Map<String, dynamic> json) => _$OtherLanguageEditionsInDbFromJson(json);

@override final  int? id;
@override final  String? lang;
@override final  String? title;
@override@JsonKey(name: 'source_id') final  String? sourceId;
@override@JsonKey(name: 'is_original') final  bool? isOriginal;
@override@JsonKey(name: 'source_type') final  String? sourceType;

/// Create a copy of OtherLanguageEditionsInDb
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtherLanguageEditionsInDbCopyWith<_OtherLanguageEditionsInDb> get copyWith => __$OtherLanguageEditionsInDbCopyWithImpl<_OtherLanguageEditionsInDb>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtherLanguageEditionsInDbToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtherLanguageEditionsInDb&&(identical(other.id, id) || other.id == id)&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.title, title) || other.title == title)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.isOriginal, isOriginal) || other.isOriginal == isOriginal)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,lang,title,sourceId,isOriginal,sourceType);

@override
String toString() {
  return 'OtherLanguageEditionsInDb(id: $id, lang: $lang, title: $title, sourceId: $sourceId, isOriginal: $isOriginal, sourceType: $sourceType)';
}


}

/// @nodoc
abstract mixin class _$OtherLanguageEditionsInDbCopyWith<$Res> implements $OtherLanguageEditionsInDbCopyWith<$Res> {
  factory _$OtherLanguageEditionsInDbCopyWith(_OtherLanguageEditionsInDb value, $Res Function(_OtherLanguageEditionsInDb) _then) = __$OtherLanguageEditionsInDbCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? lang, String? title,@JsonKey(name: 'source_id') String? sourceId,@JsonKey(name: 'is_original') bool? isOriginal,@JsonKey(name: 'source_type') String? sourceType
});




}
/// @nodoc
class __$OtherLanguageEditionsInDbCopyWithImpl<$Res>
    implements _$OtherLanguageEditionsInDbCopyWith<$Res> {
  __$OtherLanguageEditionsInDbCopyWithImpl(this._self, this._then);

  final _OtherLanguageEditionsInDb _self;
  final $Res Function(_OtherLanguageEditionsInDb) _then;

/// Create a copy of OtherLanguageEditionsInDb
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? lang = freezed,Object? title = freezed,Object? sourceId = freezed,Object? isOriginal = freezed,Object? sourceType = freezed,}) {
  return _then(_OtherLanguageEditionsInDb(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,isOriginal: freezed == isOriginal ? _self.isOriginal : isOriginal // ignore: cast_nullable_to_non_nullable
as bool?,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
