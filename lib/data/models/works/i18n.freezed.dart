// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'i18n.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$I18n {

@JsonKey(name: 'en-us') EnUs? get enUs;@JsonKey(name: 'ja-jp') JaJp? get jaJp;@JsonKey(name: 'zh-cn') ZhCn? get zhCn;
/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$I18nCopyWith<I18n> get copyWith => _$I18nCopyWithImpl<I18n>(this as I18n, _$identity);

  /// Serializes this I18n to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is I18n&&(identical(other.enUs, enUs) || other.enUs == enUs)&&(identical(other.jaJp, jaJp) || other.jaJp == jaJp)&&(identical(other.zhCn, zhCn) || other.zhCn == zhCn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enUs,jaJp,zhCn);

@override
String toString() {
  return 'I18n(enUs: $enUs, jaJp: $jaJp, zhCn: $zhCn)';
}


}

/// @nodoc
abstract mixin class $I18nCopyWith<$Res>  {
  factory $I18nCopyWith(I18n value, $Res Function(I18n) _then) = _$I18nCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'en-us') EnUs? enUs,@JsonKey(name: 'ja-jp') JaJp? jaJp,@JsonKey(name: 'zh-cn') ZhCn? zhCn
});


$EnUsCopyWith<$Res>? get enUs;$JaJpCopyWith<$Res>? get jaJp;$ZhCnCopyWith<$Res>? get zhCn;

}
/// @nodoc
class _$I18nCopyWithImpl<$Res>
    implements $I18nCopyWith<$Res> {
  _$I18nCopyWithImpl(this._self, this._then);

  final I18n _self;
  final $Res Function(I18n) _then;

/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enUs = freezed,Object? jaJp = freezed,Object? zhCn = freezed,}) {
  return _then(_self.copyWith(
enUs: freezed == enUs ? _self.enUs : enUs // ignore: cast_nullable_to_non_nullable
as EnUs?,jaJp: freezed == jaJp ? _self.jaJp : jaJp // ignore: cast_nullable_to_non_nullable
as JaJp?,zhCn: freezed == zhCn ? _self.zhCn : zhCn // ignore: cast_nullable_to_non_nullable
as ZhCn?,
  ));
}
/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnUsCopyWith<$Res>? get enUs {
    if (_self.enUs == null) {
    return null;
  }

  return $EnUsCopyWith<$Res>(_self.enUs!, (value) {
    return _then(_self.copyWith(enUs: value));
  });
}/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JaJpCopyWith<$Res>? get jaJp {
    if (_self.jaJp == null) {
    return null;
  }

  return $JaJpCopyWith<$Res>(_self.jaJp!, (value) {
    return _then(_self.copyWith(jaJp: value));
  });
}/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZhCnCopyWith<$Res>? get zhCn {
    if (_self.zhCn == null) {
    return null;
  }

  return $ZhCnCopyWith<$Res>(_self.zhCn!, (value) {
    return _then(_self.copyWith(zhCn: value));
  });
}
}


/// Adds pattern-matching-related methods to [I18n].
extension I18nPatterns on I18n {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _I18n value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _I18n() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _I18n value)  $default,){
final _that = this;
switch (_that) {
case _I18n():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _I18n value)?  $default,){
final _that = this;
switch (_that) {
case _I18n() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'en-us')  EnUs? enUs, @JsonKey(name: 'ja-jp')  JaJp? jaJp, @JsonKey(name: 'zh-cn')  ZhCn? zhCn)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _I18n() when $default != null:
return $default(_that.enUs,_that.jaJp,_that.zhCn);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'en-us')  EnUs? enUs, @JsonKey(name: 'ja-jp')  JaJp? jaJp, @JsonKey(name: 'zh-cn')  ZhCn? zhCn)  $default,) {final _that = this;
switch (_that) {
case _I18n():
return $default(_that.enUs,_that.jaJp,_that.zhCn);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'en-us')  EnUs? enUs, @JsonKey(name: 'ja-jp')  JaJp? jaJp, @JsonKey(name: 'zh-cn')  ZhCn? zhCn)?  $default,) {final _that = this;
switch (_that) {
case _I18n() when $default != null:
return $default(_that.enUs,_that.jaJp,_that.zhCn);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _I18n implements I18n {
   _I18n({@JsonKey(name: 'en-us') this.enUs, @JsonKey(name: 'ja-jp') this.jaJp, @JsonKey(name: 'zh-cn') this.zhCn});
  factory _I18n.fromJson(Map<String, dynamic> json) => _$I18nFromJson(json);

@override@JsonKey(name: 'en-us') final  EnUs? enUs;
@override@JsonKey(name: 'ja-jp') final  JaJp? jaJp;
@override@JsonKey(name: 'zh-cn') final  ZhCn? zhCn;

/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$I18nCopyWith<_I18n> get copyWith => __$I18nCopyWithImpl<_I18n>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$I18nToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _I18n&&(identical(other.enUs, enUs) || other.enUs == enUs)&&(identical(other.jaJp, jaJp) || other.jaJp == jaJp)&&(identical(other.zhCn, zhCn) || other.zhCn == zhCn));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,enUs,jaJp,zhCn);

@override
String toString() {
  return 'I18n(enUs: $enUs, jaJp: $jaJp, zhCn: $zhCn)';
}


}

/// @nodoc
abstract mixin class _$I18nCopyWith<$Res> implements $I18nCopyWith<$Res> {
  factory _$I18nCopyWith(_I18n value, $Res Function(_I18n) _then) = __$I18nCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'en-us') EnUs? enUs,@JsonKey(name: 'ja-jp') JaJp? jaJp,@JsonKey(name: 'zh-cn') ZhCn? zhCn
});


@override $EnUsCopyWith<$Res>? get enUs;@override $JaJpCopyWith<$Res>? get jaJp;@override $ZhCnCopyWith<$Res>? get zhCn;

}
/// @nodoc
class __$I18nCopyWithImpl<$Res>
    implements _$I18nCopyWith<$Res> {
  __$I18nCopyWithImpl(this._self, this._then);

  final _I18n _self;
  final $Res Function(_I18n) _then;

/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enUs = freezed,Object? jaJp = freezed,Object? zhCn = freezed,}) {
  return _then(_I18n(
enUs: freezed == enUs ? _self.enUs : enUs // ignore: cast_nullable_to_non_nullable
as EnUs?,jaJp: freezed == jaJp ? _self.jaJp : jaJp // ignore: cast_nullable_to_non_nullable
as JaJp?,zhCn: freezed == zhCn ? _self.zhCn : zhCn // ignore: cast_nullable_to_non_nullable
as ZhCn?,
  ));
}

/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EnUsCopyWith<$Res>? get enUs {
    if (_self.enUs == null) {
    return null;
  }

  return $EnUsCopyWith<$Res>(_self.enUs!, (value) {
    return _then(_self.copyWith(enUs: value));
  });
}/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JaJpCopyWith<$Res>? get jaJp {
    if (_self.jaJp == null) {
    return null;
  }

  return $JaJpCopyWith<$Res>(_self.jaJp!, (value) {
    return _then(_self.copyWith(jaJp: value));
  });
}/// Create a copy of I18n
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ZhCnCopyWith<$Res>? get zhCn {
    if (_self.zhCn == null) {
    return null;
  }

  return $ZhCnCopyWith<$Res>(_self.zhCn!, (value) {
    return _then(_self.copyWith(zhCn: value));
  });
}
}

// dart format on
