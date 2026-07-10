// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'translation_bonus_lang.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TranslationBonusLang {

 int? get price; String? get status;@JsonKey(name: 'price_tax') int? get priceTax;@JsonKey(name: 'child_count') int? get childCount;@JsonKey(name: 'price_in_tax') int? get priceInTax;@JsonKey(name: 'recipient_max') int? get recipientMax;@JsonKey(name: 'recipient_available_count') int? get recipientAvailableCount;
/// Create a copy of TranslationBonusLang
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranslationBonusLangCopyWith<TranslationBonusLang> get copyWith => _$TranslationBonusLangCopyWithImpl<TranslationBonusLang>(this as TranslationBonusLang, _$identity);

  /// Serializes this TranslationBonusLang to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranslationBonusLang&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.priceTax, priceTax) || other.priceTax == priceTax)&&(identical(other.childCount, childCount) || other.childCount == childCount)&&(identical(other.priceInTax, priceInTax) || other.priceInTax == priceInTax)&&(identical(other.recipientMax, recipientMax) || other.recipientMax == recipientMax)&&(identical(other.recipientAvailableCount, recipientAvailableCount) || other.recipientAvailableCount == recipientAvailableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,status,priceTax,childCount,priceInTax,recipientMax,recipientAvailableCount);

@override
String toString() {
  return 'TranslationBonusLang(price: $price, status: $status, priceTax: $priceTax, childCount: $childCount, priceInTax: $priceInTax, recipientMax: $recipientMax, recipientAvailableCount: $recipientAvailableCount)';
}


}

/// @nodoc
abstract mixin class $TranslationBonusLangCopyWith<$Res>  {
  factory $TranslationBonusLangCopyWith(TranslationBonusLang value, $Res Function(TranslationBonusLang) _then) = _$TranslationBonusLangCopyWithImpl;
@useResult
$Res call({
 int? price, String? status,@JsonKey(name: 'price_tax') int? priceTax,@JsonKey(name: 'child_count') int? childCount,@JsonKey(name: 'price_in_tax') int? priceInTax,@JsonKey(name: 'recipient_max') int? recipientMax,@JsonKey(name: 'recipient_available_count') int? recipientAvailableCount
});




}
/// @nodoc
class _$TranslationBonusLangCopyWithImpl<$Res>
    implements $TranslationBonusLangCopyWith<$Res> {
  _$TranslationBonusLangCopyWithImpl(this._self, this._then);

  final TranslationBonusLang _self;
  final $Res Function(TranslationBonusLang) _then;

/// Create a copy of TranslationBonusLang
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? price = freezed,Object? status = freezed,Object? priceTax = freezed,Object? childCount = freezed,Object? priceInTax = freezed,Object? recipientMax = freezed,Object? recipientAvailableCount = freezed,}) {
  return _then(_self.copyWith(
price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,priceTax: freezed == priceTax ? _self.priceTax : priceTax // ignore: cast_nullable_to_non_nullable
as int?,childCount: freezed == childCount ? _self.childCount : childCount // ignore: cast_nullable_to_non_nullable
as int?,priceInTax: freezed == priceInTax ? _self.priceInTax : priceInTax // ignore: cast_nullable_to_non_nullable
as int?,recipientMax: freezed == recipientMax ? _self.recipientMax : recipientMax // ignore: cast_nullable_to_non_nullable
as int?,recipientAvailableCount: freezed == recipientAvailableCount ? _self.recipientAvailableCount : recipientAvailableCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TranslationBonusLang].
extension TranslationBonusLangPatterns on TranslationBonusLang {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranslationBonusLang value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranslationBonusLang() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranslationBonusLang value)  $default,){
final _that = this;
switch (_that) {
case _TranslationBonusLang():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranslationBonusLang value)?  $default,){
final _that = this;
switch (_that) {
case _TranslationBonusLang() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? price,  String? status, @JsonKey(name: 'price_tax')  int? priceTax, @JsonKey(name: 'child_count')  int? childCount, @JsonKey(name: 'price_in_tax')  int? priceInTax, @JsonKey(name: 'recipient_max')  int? recipientMax, @JsonKey(name: 'recipient_available_count')  int? recipientAvailableCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranslationBonusLang() when $default != null:
return $default(_that.price,_that.status,_that.priceTax,_that.childCount,_that.priceInTax,_that.recipientMax,_that.recipientAvailableCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? price,  String? status, @JsonKey(name: 'price_tax')  int? priceTax, @JsonKey(name: 'child_count')  int? childCount, @JsonKey(name: 'price_in_tax')  int? priceInTax, @JsonKey(name: 'recipient_max')  int? recipientMax, @JsonKey(name: 'recipient_available_count')  int? recipientAvailableCount)  $default,) {final _that = this;
switch (_that) {
case _TranslationBonusLang():
return $default(_that.price,_that.status,_that.priceTax,_that.childCount,_that.priceInTax,_that.recipientMax,_that.recipientAvailableCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? price,  String? status, @JsonKey(name: 'price_tax')  int? priceTax, @JsonKey(name: 'child_count')  int? childCount, @JsonKey(name: 'price_in_tax')  int? priceInTax, @JsonKey(name: 'recipient_max')  int? recipientMax, @JsonKey(name: 'recipient_available_count')  int? recipientAvailableCount)?  $default,) {final _that = this;
switch (_that) {
case _TranslationBonusLang() when $default != null:
return $default(_that.price,_that.status,_that.priceTax,_that.childCount,_that.priceInTax,_that.recipientMax,_that.recipientAvailableCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TranslationBonusLang implements TranslationBonusLang {
   _TranslationBonusLang({this.price, this.status, @JsonKey(name: 'price_tax') this.priceTax, @JsonKey(name: 'child_count') this.childCount, @JsonKey(name: 'price_in_tax') this.priceInTax, @JsonKey(name: 'recipient_max') this.recipientMax, @JsonKey(name: 'recipient_available_count') this.recipientAvailableCount});
  factory _TranslationBonusLang.fromJson(Map<String, dynamic> json) => _$TranslationBonusLangFromJson(json);

@override final  int? price;
@override final  String? status;
@override@JsonKey(name: 'price_tax') final  int? priceTax;
@override@JsonKey(name: 'child_count') final  int? childCount;
@override@JsonKey(name: 'price_in_tax') final  int? priceInTax;
@override@JsonKey(name: 'recipient_max') final  int? recipientMax;
@override@JsonKey(name: 'recipient_available_count') final  int? recipientAvailableCount;

/// Create a copy of TranslationBonusLang
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranslationBonusLangCopyWith<_TranslationBonusLang> get copyWith => __$TranslationBonusLangCopyWithImpl<_TranslationBonusLang>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TranslationBonusLangToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranslationBonusLang&&(identical(other.price, price) || other.price == price)&&(identical(other.status, status) || other.status == status)&&(identical(other.priceTax, priceTax) || other.priceTax == priceTax)&&(identical(other.childCount, childCount) || other.childCount == childCount)&&(identical(other.priceInTax, priceInTax) || other.priceInTax == priceInTax)&&(identical(other.recipientMax, recipientMax) || other.recipientMax == recipientMax)&&(identical(other.recipientAvailableCount, recipientAvailableCount) || other.recipientAvailableCount == recipientAvailableCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,price,status,priceTax,childCount,priceInTax,recipientMax,recipientAvailableCount);

@override
String toString() {
  return 'TranslationBonusLang(price: $price, status: $status, priceTax: $priceTax, childCount: $childCount, priceInTax: $priceInTax, recipientMax: $recipientMax, recipientAvailableCount: $recipientAvailableCount)';
}


}

/// @nodoc
abstract mixin class _$TranslationBonusLangCopyWith<$Res> implements $TranslationBonusLangCopyWith<$Res> {
  factory _$TranslationBonusLangCopyWith(_TranslationBonusLang value, $Res Function(_TranslationBonusLang) _then) = __$TranslationBonusLangCopyWithImpl;
@override @useResult
$Res call({
 int? price, String? status,@JsonKey(name: 'price_tax') int? priceTax,@JsonKey(name: 'child_count') int? childCount,@JsonKey(name: 'price_in_tax') int? priceInTax,@JsonKey(name: 'recipient_max') int? recipientMax,@JsonKey(name: 'recipient_available_count') int? recipientAvailableCount
});




}
/// @nodoc
class __$TranslationBonusLangCopyWithImpl<$Res>
    implements _$TranslationBonusLangCopyWith<$Res> {
  __$TranslationBonusLangCopyWithImpl(this._self, this._then);

  final _TranslationBonusLang _self;
  final $Res Function(_TranslationBonusLang) _then;

/// Create a copy of TranslationBonusLang
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? price = freezed,Object? status = freezed,Object? priceTax = freezed,Object? childCount = freezed,Object? priceInTax = freezed,Object? recipientMax = freezed,Object? recipientAvailableCount = freezed,}) {
  return _then(_TranslationBonusLang(
price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,priceTax: freezed == priceTax ? _self.priceTax : priceTax // ignore: cast_nullable_to_non_nullable
as int?,childCount: freezed == childCount ? _self.childCount : childCount // ignore: cast_nullable_to_non_nullable
as int?,priceInTax: freezed == priceInTax ? _self.priceInTax : priceInTax // ignore: cast_nullable_to_non_nullable
as int?,recipientMax: freezed == recipientMax ? _self.recipientMax : recipientMax // ignore: cast_nullable_to_non_nullable
as int?,recipientAvailableCount: freezed == recipientAvailableCount ? _self.recipientAvailableCount : recipientAvailableCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
