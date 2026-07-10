// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranslationInfo {

 String? get lang;@JsonKey(name: 'is_child') bool? get isChild;@JsonKey(name: 'is_parent') bool? get isParent;@JsonKey(name: 'is_original') bool? get isOriginal;@JsonKey(name: 'is_volunteer') bool? get isVolunteer;@JsonKey(name: 'child_worknos') List<dynamic>? get childWorknos;@JsonKey(name: 'parent_workno') String? get parentWorkno;@JsonKey(name: 'original_workno') String? get originalWorkno;@JsonKey(name: 'is_translation_agree') bool? get isTranslationAgree;@JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson) Map<String, TranslationBonusLang>? get translationBonusLangs;@JsonKey(name: 'is_translation_bonus_child') bool? get isTranslationBonusChild;@JsonKey(name: 'production_trade_price_rate') int? get productionTradePriceRate;
/// Create a copy of TranslationInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationInfoCopyWith<TranslationInfo> get copyWith => _$TranslationInfoCopyWithImpl<TranslationInfo>(this as TranslationInfo, _$identity);

  /// Serializes this TranslationInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationInfo&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.isChild, isChild) || other.isChild == isChild)&&(identical(other.isParent, isParent) || other.isParent == isParent)&&(identical(other.isOriginal, isOriginal) || other.isOriginal == isOriginal)&&(identical(other.isVolunteer, isVolunteer) || other.isVolunteer == isVolunteer)&&const DeepCollectionEquality().equals(other.childWorknos, childWorknos)&&(identical(other.parentWorkno, parentWorkno) || other.parentWorkno == parentWorkno)&&(identical(other.originalWorkno, originalWorkno) || other.originalWorkno == originalWorkno)&&(identical(other.isTranslationAgree, isTranslationAgree) || other.isTranslationAgree == isTranslationAgree)&&const DeepCollectionEquality().equals(other.translationBonusLangs, translationBonusLangs)&&(identical(other.isTranslationBonusChild, isTranslationBonusChild) || other.isTranslationBonusChild == isTranslationBonusChild)&&(identical(other.productionTradePriceRate, productionTradePriceRate) || other.productionTradePriceRate == productionTradePriceRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,isChild,isParent,isOriginal,isVolunteer,const DeepCollectionEquality().hash(childWorknos),parentWorkno,originalWorkno,isTranslationAgree,const DeepCollectionEquality().hash(translationBonusLangs),isTranslationBonusChild,productionTradePriceRate);

@override
String toString() {
  return 'TranslationInfo(lang: $lang, isChild: $isChild, isParent: $isParent, isOriginal: $isOriginal, isVolunteer: $isVolunteer, childWorknos: $childWorknos, parentWorkno: $parentWorkno, originalWorkno: $originalWorkno, isTranslationAgree: $isTranslationAgree, translationBonusLangs: $translationBonusLangs, isTranslationBonusChild: $isTranslationBonusChild, productionTradePriceRate: $productionTradePriceRate)';
}


}

/// @nodoc
abstract mixin class $TranslationInfoCopyWith<$Res>  {
  factory $TranslationInfoCopyWith(TranslationInfo value, $Res Function(TranslationInfo) _then) = _$TranslationInfoCopyWithImpl;
@useResult
$Res call({
 String? lang,@JsonKey(name: 'is_child') bool? isChild,@JsonKey(name: 'is_parent') bool? isParent,@JsonKey(name: 'is_original') bool? isOriginal,@JsonKey(name: 'is_volunteer') bool? isVolunteer,@JsonKey(name: 'child_worknos') List<dynamic>? childWorknos,@JsonKey(name: 'parent_workno') String? parentWorkno,@JsonKey(name: 'original_workno') String? originalWorkno,@JsonKey(name: 'is_translation_agree') bool? isTranslationAgree,@JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson) Map<String, TranslationBonusLang>? translationBonusLangs,@JsonKey(name: 'is_translation_bonus_child') bool? isTranslationBonusChild,@JsonKey(name: 'production_trade_price_rate') int? productionTradePriceRate
});




}
/// @nodoc
class _$TranslationInfoCopyWithImpl<$Res>
    implements $TranslationInfoCopyWith<$Res> {
  _$TranslationInfoCopyWithImpl(this._self, this._then);

  final TranslationInfo _self;
  final $Res Function(TranslationInfo) _then;

/// Create a copy of TranslationInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lang = freezed,Object? isChild = freezed,Object? isParent = freezed,Object? isOriginal = freezed,Object? isVolunteer = freezed,Object? childWorknos = freezed,Object? parentWorkno = freezed,Object? originalWorkno = freezed,Object? isTranslationAgree = freezed,Object? translationBonusLangs = freezed,Object? isTranslationBonusChild = freezed,Object? productionTradePriceRate = freezed,}) {
  return _then(_self.copyWith(
lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,isChild: freezed == isChild ? _self.isChild : isChild // ignore: cast_nullable_to_non_nullable
as bool?,isParent: freezed == isParent ? _self.isParent : isParent // ignore: cast_nullable_to_non_nullable
as bool?,isOriginal: freezed == isOriginal ? _self.isOriginal : isOriginal // ignore: cast_nullable_to_non_nullable
as bool?,isVolunteer: freezed == isVolunteer ? _self.isVolunteer : isVolunteer // ignore: cast_nullable_to_non_nullable
as bool?,childWorknos: freezed == childWorknos ? _self.childWorknos : childWorknos // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,parentWorkno: freezed == parentWorkno ? _self.parentWorkno : parentWorkno // ignore: cast_nullable_to_non_nullable
as String?,originalWorkno: freezed == originalWorkno ? _self.originalWorkno : originalWorkno // ignore: cast_nullable_to_non_nullable
as String?,isTranslationAgree: freezed == isTranslationAgree ? _self.isTranslationAgree : isTranslationAgree // ignore: cast_nullable_to_non_nullable
as bool?,translationBonusLangs: freezed == translationBonusLangs ? _self.translationBonusLangs : translationBonusLangs // ignore: cast_nullable_to_non_nullable
as Map<String, TranslationBonusLang>?,isTranslationBonusChild: freezed == isTranslationBonusChild ? _self.isTranslationBonusChild : isTranslationBonusChild // ignore: cast_nullable_to_non_nullable
as bool?,productionTradePriceRate: freezed == productionTradePriceRate ? _self.productionTradePriceRate : productionTradePriceRate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationInfo].
extension TranslationInfoPatterns on TranslationInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationInfo value)  $default,){
final _that = this;
switch (_that) {
case _TranslationInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationInfo value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? lang, @JsonKey(name: 'is_child')  bool? isChild, @JsonKey(name: 'is_parent')  bool? isParent, @JsonKey(name: 'is_original')  bool? isOriginal, @JsonKey(name: 'is_volunteer')  bool? isVolunteer, @JsonKey(name: 'child_worknos')  List<dynamic>? childWorknos, @JsonKey(name: 'parent_workno')  String? parentWorkno, @JsonKey(name: 'original_workno')  String? originalWorkno, @JsonKey(name: 'is_translation_agree')  bool? isTranslationAgree, @JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson)  Map<String, TranslationBonusLang>? translationBonusLangs, @JsonKey(name: 'is_translation_bonus_child')  bool? isTranslationBonusChild, @JsonKey(name: 'production_trade_price_rate')  int? productionTradePriceRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationInfo() when $default != null:
return $default(_that.lang,_that.isChild,_that.isParent,_that.isOriginal,_that.isVolunteer,_that.childWorknos,_that.parentWorkno,_that.originalWorkno,_that.isTranslationAgree,_that.translationBonusLangs,_that.isTranslationBonusChild,_that.productionTradePriceRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? lang, @JsonKey(name: 'is_child')  bool? isChild, @JsonKey(name: 'is_parent')  bool? isParent, @JsonKey(name: 'is_original')  bool? isOriginal, @JsonKey(name: 'is_volunteer')  bool? isVolunteer, @JsonKey(name: 'child_worknos')  List<dynamic>? childWorknos, @JsonKey(name: 'parent_workno')  String? parentWorkno, @JsonKey(name: 'original_workno')  String? originalWorkno, @JsonKey(name: 'is_translation_agree')  bool? isTranslationAgree, @JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson)  Map<String, TranslationBonusLang>? translationBonusLangs, @JsonKey(name: 'is_translation_bonus_child')  bool? isTranslationBonusChild, @JsonKey(name: 'production_trade_price_rate')  int? productionTradePriceRate)  $default,) {final _that = this;
switch (_that) {
case _TranslationInfo():
return $default(_that.lang,_that.isChild,_that.isParent,_that.isOriginal,_that.isVolunteer,_that.childWorknos,_that.parentWorkno,_that.originalWorkno,_that.isTranslationAgree,_that.translationBonusLangs,_that.isTranslationBonusChild,_that.productionTradePriceRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? lang, @JsonKey(name: 'is_child')  bool? isChild, @JsonKey(name: 'is_parent')  bool? isParent, @JsonKey(name: 'is_original')  bool? isOriginal, @JsonKey(name: 'is_volunteer')  bool? isVolunteer, @JsonKey(name: 'child_worknos')  List<dynamic>? childWorknos, @JsonKey(name: 'parent_workno')  String? parentWorkno, @JsonKey(name: 'original_workno')  String? originalWorkno, @JsonKey(name: 'is_translation_agree')  bool? isTranslationAgree, @JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson)  Map<String, TranslationBonusLang>? translationBonusLangs, @JsonKey(name: 'is_translation_bonus_child')  bool? isTranslationBonusChild, @JsonKey(name: 'production_trade_price_rate')  int? productionTradePriceRate)?  $default,) {final _that = this;
switch (_that) {
case _TranslationInfo() when $default != null:
return $default(_that.lang,_that.isChild,_that.isParent,_that.isOriginal,_that.isVolunteer,_that.childWorknos,_that.parentWorkno,_that.originalWorkno,_that.isTranslationAgree,_that.translationBonusLangs,_that.isTranslationBonusChild,_that.productionTradePriceRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationInfo implements TranslationInfo {
   _TranslationInfo({this.lang, @JsonKey(name: 'is_child') this.isChild, @JsonKey(name: 'is_parent') this.isParent, @JsonKey(name: 'is_original') this.isOriginal, @JsonKey(name: 'is_volunteer') this.isVolunteer, @JsonKey(name: 'child_worknos') final  List<dynamic>? childWorknos, @JsonKey(name: 'parent_workno') this.parentWorkno, @JsonKey(name: 'original_workno') this.originalWorkno, @JsonKey(name: 'is_translation_agree') this.isTranslationAgree, @JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson) final  Map<String, TranslationBonusLang>? translationBonusLangs, @JsonKey(name: 'is_translation_bonus_child') this.isTranslationBonusChild, @JsonKey(name: 'production_trade_price_rate') this.productionTradePriceRate}): _childWorknos = childWorknos,_translationBonusLangs = translationBonusLangs;
  factory _TranslationInfo.fromJson(Map<String, dynamic> json) => _$TranslationInfoFromJson(json);

@override final  String? lang;
@override@JsonKey(name: 'is_child') final  bool? isChild;
@override@JsonKey(name: 'is_parent') final  bool? isParent;
@override@JsonKey(name: 'is_original') final  bool? isOriginal;
@override@JsonKey(name: 'is_volunteer') final  bool? isVolunteer;
 final  List<dynamic>? _childWorknos;
@override@JsonKey(name: 'child_worknos') List<dynamic>? get childWorknos {
  final value = _childWorknos;
  if (value == null) return null;
  if (_childWorknos is EqualUnmodifiableListView) return _childWorknos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'parent_workno') final  String? parentWorkno;
@override@JsonKey(name: 'original_workno') final  String? originalWorkno;
@override@JsonKey(name: 'is_translation_agree') final  bool? isTranslationAgree;
 final  Map<String, TranslationBonusLang>? _translationBonusLangs;
@override@JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson) Map<String, TranslationBonusLang>? get translationBonusLangs {
  final value = _translationBonusLangs;
  if (value == null) return null;
  if (_translationBonusLangs is EqualUnmodifiableMapView) return _translationBonusLangs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'is_translation_bonus_child') final  bool? isTranslationBonusChild;
@override@JsonKey(name: 'production_trade_price_rate') final  int? productionTradePriceRate;

/// Create a copy of TranslationInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationInfoCopyWith<_TranslationInfo> get copyWith => __$TranslationInfoCopyWithImpl<_TranslationInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationInfo&&(identical(other.lang, lang) || other.lang == lang)&&(identical(other.isChild, isChild) || other.isChild == isChild)&&(identical(other.isParent, isParent) || other.isParent == isParent)&&(identical(other.isOriginal, isOriginal) || other.isOriginal == isOriginal)&&(identical(other.isVolunteer, isVolunteer) || other.isVolunteer == isVolunteer)&&const DeepCollectionEquality().equals(other._childWorknos, _childWorknos)&&(identical(other.parentWorkno, parentWorkno) || other.parentWorkno == parentWorkno)&&(identical(other.originalWorkno, originalWorkno) || other.originalWorkno == originalWorkno)&&(identical(other.isTranslationAgree, isTranslationAgree) || other.isTranslationAgree == isTranslationAgree)&&const DeepCollectionEquality().equals(other._translationBonusLangs, _translationBonusLangs)&&(identical(other.isTranslationBonusChild, isTranslationBonusChild) || other.isTranslationBonusChild == isTranslationBonusChild)&&(identical(other.productionTradePriceRate, productionTradePriceRate) || other.productionTradePriceRate == productionTradePriceRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lang,isChild,isParent,isOriginal,isVolunteer,const DeepCollectionEquality().hash(_childWorknos),parentWorkno,originalWorkno,isTranslationAgree,const DeepCollectionEquality().hash(_translationBonusLangs),isTranslationBonusChild,productionTradePriceRate);

@override
String toString() {
  return 'TranslationInfo(lang: $lang, isChild: $isChild, isParent: $isParent, isOriginal: $isOriginal, isVolunteer: $isVolunteer, childWorknos: $childWorknos, parentWorkno: $parentWorkno, originalWorkno: $originalWorkno, isTranslationAgree: $isTranslationAgree, translationBonusLangs: $translationBonusLangs, isTranslationBonusChild: $isTranslationBonusChild, productionTradePriceRate: $productionTradePriceRate)';
}


}

/// @nodoc
abstract mixin class _$TranslationInfoCopyWith<$Res> implements $TranslationInfoCopyWith<$Res> {
  factory _$TranslationInfoCopyWith(_TranslationInfo value, $Res Function(_TranslationInfo) _then) = __$TranslationInfoCopyWithImpl;
@override @useResult
$Res call({
 String? lang,@JsonKey(name: 'is_child') bool? isChild,@JsonKey(name: 'is_parent') bool? isParent,@JsonKey(name: 'is_original') bool? isOriginal,@JsonKey(name: 'is_volunteer') bool? isVolunteer,@JsonKey(name: 'child_worknos') List<dynamic>? childWorknos,@JsonKey(name: 'parent_workno') String? parentWorkno,@JsonKey(name: 'original_workno') String? originalWorkno,@JsonKey(name: 'is_translation_agree') bool? isTranslationAgree,@JsonKey(name: 'translation_bonus_langs', fromJson: _translationBonusLangsFromJson, toJson: _translationBonusLangsToJson) Map<String, TranslationBonusLang>? translationBonusLangs,@JsonKey(name: 'is_translation_bonus_child') bool? isTranslationBonusChild,@JsonKey(name: 'production_trade_price_rate') int? productionTradePriceRate
});




}
/// @nodoc
class __$TranslationInfoCopyWithImpl<$Res>
    implements _$TranslationInfoCopyWith<$Res> {
  __$TranslationInfoCopyWithImpl(this._self, this._then);

  final _TranslationInfo _self;
  final $Res Function(_TranslationInfo) _then;

/// Create a copy of TranslationInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lang = freezed,Object? isChild = freezed,Object? isParent = freezed,Object? isOriginal = freezed,Object? isVolunteer = freezed,Object? childWorknos = freezed,Object? parentWorkno = freezed,Object? originalWorkno = freezed,Object? isTranslationAgree = freezed,Object? translationBonusLangs = freezed,Object? isTranslationBonusChild = freezed,Object? productionTradePriceRate = freezed,}) {
  return _then(_TranslationInfo(
lang: freezed == lang ? _self.lang : lang // ignore: cast_nullable_to_non_nullable
as String?,isChild: freezed == isChild ? _self.isChild : isChild // ignore: cast_nullable_to_non_nullable
as bool?,isParent: freezed == isParent ? _self.isParent : isParent // ignore: cast_nullable_to_non_nullable
as bool?,isOriginal: freezed == isOriginal ? _self.isOriginal : isOriginal // ignore: cast_nullable_to_non_nullable
as bool?,isVolunteer: freezed == isVolunteer ? _self.isVolunteer : isVolunteer // ignore: cast_nullable_to_non_nullable
as bool?,childWorknos: freezed == childWorknos ? _self._childWorknos : childWorknos // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,parentWorkno: freezed == parentWorkno ? _self.parentWorkno : parentWorkno // ignore: cast_nullable_to_non_nullable
as String?,originalWorkno: freezed == originalWorkno ? _self.originalWorkno : originalWorkno // ignore: cast_nullable_to_non_nullable
as String?,isTranslationAgree: freezed == isTranslationAgree ? _self.isTranslationAgree : isTranslationAgree // ignore: cast_nullable_to_non_nullable
as bool?,translationBonusLangs: freezed == translationBonusLangs ? _self._translationBonusLangs : translationBonusLangs // ignore: cast_nullable_to_non_nullable
as Map<String, TranslationBonusLang>?,isTranslationBonusChild: freezed == isTranslationBonusChild ? _self.isTranslationBonusChild : isTranslationBonusChild // ignore: cast_nullable_to_non_nullable
as bool?,productionTradePriceRate: freezed == productionTradePriceRate ? _self.productionTradePriceRate : productionTradePriceRate // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
