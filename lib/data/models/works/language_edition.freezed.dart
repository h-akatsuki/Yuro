// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_edition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LanguageEdition {

 String? get lang; String? get label; String? get workno;@JsonKey(name: 'edition_id') int? get editionId;@JsonKey(name: 'edition_type') String? get editionType;@JsonKey(name: 'display_order') int? get displayOrder;
/// Create a copy of LanguageEdition
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageEditionCopyWith<LanguageEdition> get copyWith => _$LanguageEditionCopyWithImpl<LanguageEdition>(this as LanguageEdition, _$identity);

  /// Serializes this LanguageEdition to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageEdition&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.label, label) || other.label == label)&&(identical(other.workno, workno) || other.workno == workno)&&(identical(other.editionId, editionId) || other.editionId == editionId)&&(identical(other.editionType, editionType) || other.editionType == editionType)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,label,workno,editionId,editionType,displayOrder);

@override
String toString() {
  return 'LanguageEdition(lang: $lang, label: $label, workno: $workno, editionId: $editionId, editionType: $editionType, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class $LanguageEditionCopyWith<$Res>  {
  factory $LanguageEditionCopyWith(LanguageEdition value, $Res Function(LanguageEdition) _then) = _$LanguageEditionCopyWithImpl;
@useResult
$Res call({
 String? lang, String? label, String? workno,@JsonKey(name: 'edition_id') int? editionId,@JsonKey(name: 'edition_type') String? editionType,@JsonKey(name: 'display_order') int? displayOrder
});




}
/// @nodoc
class _$LanguageEditionCopyWithImpl<$Res>
    implements $LanguageEditionCopyWith<$Res> {
  _$LanguageEditionCopyWithImpl(this._self, this._then);

  final LanguageEdition _self;
  final $Res Function(LanguageEdition) _then;

/// Create a copy of LanguageEdition
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lang = freezed,Object? label = freezed,Object? workno = freezed,Object? editionId = freezed,Object? editionType = freezed,Object? displayOrder = freezed,}) {
  return _then(_self.copyWith(
lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,workno: freezed == workno ? _self.workno : workno // ignore: cast_nullable_to_non_nullable
as String?,editionId: freezed == editionId ? _self.editionId : editionId // ignore: cast_nullable_to_non_nullable
as int?,editionType: freezed == editionType ? _self.editionType : editionType // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageEdition].
extension LanguageEditionPatterns on LanguageEdition {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageEdition value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageEdition() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageEdition value)  $default,){
final _that = this;
switch (_that) {
case _LanguageEdition():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageEdition value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageEdition() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? lang,  String? label,  String? workno, @JsonKey(name: 'edition_id')  int? editionId, @JsonKey(name: 'edition_type')  String? editionType, @JsonKey(name: 'display_order')  int? displayOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageEdition() when $default != null:
return $default(_that.lang,_that.label,_that.workno,_that.editionId,_that.editionType,_that.displayOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? lang,  String? label,  String? workno, @JsonKey(name: 'edition_id')  int? editionId, @JsonKey(name: 'edition_type')  String? editionType, @JsonKey(name: 'display_order')  int? displayOrder)  $default,) {final _that = this;
switch (_that) {
case _LanguageEdition():
return $default(_that.lang,_that.label,_that.workno,_that.editionId,_that.editionType,_that.displayOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? lang,  String? label,  String? workno, @JsonKey(name: 'edition_id')  int? editionId, @JsonKey(name: 'edition_type')  String? editionType, @JsonKey(name: 'display_order')  int? displayOrder)?  $default,) {final _that = this;
switch (_that) {
case _LanguageEdition() when $default != null:
return $default(_that.lang,_that.label,_that.workno,_that.editionId,_that.editionType,_that.displayOrder);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LanguageEdition implements LanguageEdition {
   _LanguageEdition({this.lang, this.label, this.workno, @JsonKey(name: 'edition_id') this.editionId, @JsonKey(name: 'edition_type') this.editionType, @JsonKey(name: 'display_order') this.displayOrder});
  factory _LanguageEdition.fromJson(Map<String, dynamic> json) => _$LanguageEditionFromJson(json);

@override final  String? lang;
@override final  String? label;
@override final  String? workno;
@override@JsonKey(name: 'edition_id') final  int? editionId;
@override@JsonKey(name: 'edition_type') final  String? editionType;
@override@JsonKey(name: 'display_order') final  int? displayOrder;

/// Create a copy of LanguageEdition
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageEditionCopyWith<_LanguageEdition> get copyWith => __$LanguageEditionCopyWithImpl<_LanguageEdition>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageEditionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageEdition&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.label, label) || other.label == label)&&(identical(other.workno, workno) || other.workno == workno)&&(identical(other.editionId, editionId) || other.editionId == editionId)&&(identical(other.editionType, editionType) || other.editionType == editionType)&&(identical(other.displayOrder, displayOrder) || other.displayOrder == displayOrder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,label,workno,editionId,editionType,displayOrder);

@override
String toString() {
  return 'LanguageEdition(lang: $lang, label: $label, workno: $workno, editionId: $editionId, editionType: $editionType, displayOrder: $displayOrder)';
}


}

/// @nodoc
abstract mixin class _$LanguageEditionCopyWith<$Res> implements $LanguageEditionCopyWith<$Res> {
  factory _$LanguageEditionCopyWith(_LanguageEdition value, $Res Function(_LanguageEdition) _then) = __$LanguageEditionCopyWithImpl;
@override @useResult
$Res call({
 String? lang, String? label, String? workno,@JsonKey(name: 'edition_id') int? editionId,@JsonKey(name: 'edition_type') String? editionType,@JsonKey(name: 'display_order') int? displayOrder
});




}
/// @nodoc
class __$LanguageEditionCopyWithImpl<$Res>
    implements _$LanguageEditionCopyWith<$Res> {
  __$LanguageEditionCopyWithImpl(this._self, this._then);

  final _LanguageEdition _self;
  final $Res Function(_LanguageEdition) _then;

/// Create a copy of LanguageEdition
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lang = freezed,Object? label = freezed,Object? workno = freezed,Object? editionId = freezed,Object? editionType = freezed,Object? displayOrder = freezed,}) {
  return _then(_LanguageEdition(
lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,workno: freezed == workno ? _self.workno : workno // ignore: cast_nullable_to_non_nullable
as String?,editionId: freezed == editionId ? _self.editionId : editionId // ignore: cast_nullable_to_non_nullable
as int?,editionType: freezed == editionType ? _self.editionType : editionType // ignore: cast_nullable_to_non_nullable
as String?,displayOrder: freezed == displayOrder ? _self.displayOrder : displayOrder // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
