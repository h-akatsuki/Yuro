// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Work {

 int? get id; String? get title;@JsonKey(name: 'circle_id') int? get circleId; String? get name; bool? get nsfw; String? get release;@JsonKey(name: 'dl_count') int? get dlCount; int? get price;@JsonKey(name: 'review_count') int? get reviewCount;@JsonKey(name: 'rate_count') int? get rateCount;@JsonKey(name: 'rate_average_2dp') int? get rateAverage2dp;@JsonKey(name: 'rate_count_detail') List<dynamic>? get rateCountDetail; dynamic get rank;@JsonKey(name: 'has_subtitle') bool? get hasSubtitle;@JsonKey(name: 'create_date') String? get createDate; List<dynamic>? get vas; List<Tag>? get tags;@JsonKey(name: 'language_editions') List<LanguageEdition>? get languageEditions;@JsonKey(name: 'original_workno') String? get originalWorkno;@JsonKey(name: 'other_language_editions_in_db') List<OtherLanguageEditionsInDb>? get otherLanguageEditionsInDb;@JsonKey(name: 'translation_info') TranslationInfo? get translationInfo;@JsonKey(name: 'work_attributes') String? get workAttributes;@JsonKey(name: 'age_category_string') String? get ageCategoryString; int? get duration;@JsonKey(name: 'source_type') String? get sourceType;@JsonKey(name: 'source_id') String? get sourceId;@JsonKey(name: 'source_url') String? get sourceUrl; dynamic get userRating; Circle? get circle; String? get samCoverUrl; String? get thumbnailCoverUrl; String? get mainCoverUrl;
/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkCopyWith<Work> get copyWith => _$WorkCopyWithImpl<Work>(this as Work, _$identity);

  /// Serializes this Work to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Work&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.release, release) || other.release == release)&&(identical(other.dlCount, dlCount) || other.dlCount == dlCount)&&(identical(other.price, price) || other.price == price)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.rateCount, rateCount) || other.rateCount == rateCount)&&(identical(other.rateAverage2dp, rateAverage2dp) || other.rateAverage2dp == rateAverage2dp)&&const DeepCollectionEquality().equals(other.rateCountDetail, rateCountDetail)&&const DeepCollectionEquality().equals(other.rank, rank)&&(identical(other.hasSubtitle, hasSubtitle) || other.hasSubtitle == hasSubtitle)&&(identical(other.createDate, createDate) || other.createDate == createDate)&&const DeepCollectionEquality().equals(other.vas, vas)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.languageEditions, languageEditions)&&(identical(other.originalWorkno, originalWorkno) || other.originalWorkno == originalWorkno)&&const DeepCollectionEquality().equals(other.otherLanguageEditionsInDb, otherLanguageEditionsInDb)&&(identical(other.translationInfo, translationInfo) || other.translationInfo == translationInfo)&&(identical(other.workAttributes, workAttributes) || other.workAttributes == workAttributes)&&(identical(other.ageCategoryString, ageCategoryString) || other.ageCategoryString == ageCategoryString)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&const DeepCollectionEquality().equals(other.userRating, userRating)&&(identical(other.circle, circle) || other.circle == circle)&&(identical(other.samCoverUrl, samCoverUrl) || other.samCoverUrl == samCoverUrl)&&(identical(other.thumbnailCoverUrl, thumbnailCoverUrl) || other.thumbnailCoverUrl == thumbnailCoverUrl)&&(identical(other.mainCoverUrl, mainCoverUrl) || other.mainCoverUrl == mainCoverUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,circleId,name,nsfw,release,dlCount,price,reviewCount,rateCount,rateAverage2dp,const DeepCollectionEquality().hash(rateCountDetail),const DeepCollectionEquality().hash(rank),hasSubtitle,createDate,const DeepCollectionEquality().hash(vas),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(languageEditions),originalWorkno,const DeepCollectionEquality().hash(otherLanguageEditionsInDb),translationInfo,workAttributes,ageCategoryString,duration,sourceType,sourceId,sourceUrl,const DeepCollectionEquality().hash(userRating),circle,samCoverUrl,thumbnailCoverUrl,mainCoverUrl]);

@override
String toString() {
  return 'Work(id: $id, title: $title, circleId: $circleId, name: $name, nsfw: $nsfw, release: $release, dlCount: $dlCount, price: $price, reviewCount: $reviewCount, rateCount: $rateCount, rateAverage2dp: $rateAverage2dp, rateCountDetail: $rateCountDetail, rank: $rank, hasSubtitle: $hasSubtitle, createDate: $createDate, vas: $vas, tags: $tags, languageEditions: $languageEditions, originalWorkno: $originalWorkno, otherLanguageEditionsInDb: $otherLanguageEditionsInDb, translationInfo: $translationInfo, workAttributes: $workAttributes, ageCategoryString: $ageCategoryString, duration: $duration, sourceType: $sourceType, sourceId: $sourceId, sourceUrl: $sourceUrl, userRating: $userRating, circle: $circle, samCoverUrl: $samCoverUrl, thumbnailCoverUrl: $thumbnailCoverUrl, mainCoverUrl: $mainCoverUrl)';
}


}

/// @nodoc
abstract mixin class $WorkCopyWith<$Res>  {
  factory $WorkCopyWith(Work value, $Res Function(Work) _then) = _$WorkCopyWithImpl;
@useResult
$Res call({
 int? id, String? title,@JsonKey(name: 'circle_id') int? circleId, String? name, bool? nsfw, String? release,@JsonKey(name: 'dl_count') int? dlCount, int? price,@JsonKey(name: 'review_count') int? reviewCount,@JsonKey(name: 'rate_count') int? rateCount,@JsonKey(name: 'rate_average_2dp') int? rateAverage2dp,@JsonKey(name: 'rate_count_detail') List<dynamic>? rateCountDetail, dynamic rank,@JsonKey(name: 'has_subtitle') bool? hasSubtitle,@JsonKey(name: 'create_date') String? createDate, List<dynamic>? vas, List<Tag>? tags,@JsonKey(name: 'language_editions') List<LanguageEdition>? languageEditions,@JsonKey(name: 'original_workno') String? originalWorkno,@JsonKey(name: 'other_language_editions_in_db') List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb,@JsonKey(name: 'translation_info') TranslationInfo? translationInfo,@JsonKey(name: 'work_attributes') String? workAttributes,@JsonKey(name: 'age_category_string') String? ageCategoryString, int? duration,@JsonKey(name: 'source_type') String? sourceType,@JsonKey(name: 'source_id') String? sourceId,@JsonKey(name: 'source_url') String? sourceUrl, dynamic userRating, Circle? circle, String? samCoverUrl, String? thumbnailCoverUrl, String? mainCoverUrl
});


$TranslationInfoCopyWith<$Res>? get translationInfo;$CircleCopyWith<$Res>? get circle;

}
/// @nodoc
class _$WorkCopyWithImpl<$Res>
    implements $WorkCopyWith<$Res> {
  _$WorkCopyWithImpl(this._self, this._then);

  final Work _self;
  final $Res Function(Work) _then;

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? circleId = freezed,Object? name = freezed,Object? nsfw = freezed,Object? release = freezed,Object? dlCount = freezed,Object? price = freezed,Object? reviewCount = freezed,Object? rateCount = freezed,Object? rateAverage2dp = freezed,Object? rateCountDetail = freezed,Object? rank = freezed,Object? hasSubtitle = freezed,Object? createDate = freezed,Object? vas = freezed,Object? tags = freezed,Object? languageEditions = freezed,Object? originalWorkno = freezed,Object? otherLanguageEditionsInDb = freezed,Object? translationInfo = freezed,Object? workAttributes = freezed,Object? ageCategoryString = freezed,Object? duration = freezed,Object? sourceType = freezed,Object? sourceId = freezed,Object? sourceUrl = freezed,Object? userRating = freezed,Object? circle = freezed,Object? samCoverUrl = freezed,Object? thumbnailCoverUrl = freezed,Object? mainCoverUrl = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,circleId: freezed == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nsfw: freezed == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool?,release: freezed == release ? _self.release : release // ignore: cast_nullable_to_non_nullable
as String?,dlCount: freezed == dlCount ? _self.dlCount : dlCount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,rateCount: freezed == rateCount ? _self.rateCount : rateCount // ignore: cast_nullable_to_non_nullable
as int?,rateAverage2dp: freezed == rateAverage2dp ? _self.rateAverage2dp : rateAverage2dp // ignore: cast_nullable_to_non_nullable
as int?,rateCountDetail: freezed == rateCountDetail ? _self.rateCountDetail : rateCountDetail // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as dynamic,hasSubtitle: freezed == hasSubtitle ? _self.hasSubtitle : hasSubtitle // ignore: cast_nullable_to_non_nullable
as bool?,createDate: freezed == createDate ? _self.createDate : createDate // ignore: cast_nullable_to_non_nullable
as String?,vas: freezed == vas ? _self.vas : vas // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>?,languageEditions: freezed == languageEditions ? _self.languageEditions : languageEditions // ignore: cast_nullable_to_non_nullable
as List<LanguageEdition>?,originalWorkno: freezed == originalWorkno ? _self.originalWorkno : originalWorkno // ignore: cast_nullable_to_non_nullable
as String?,otherLanguageEditionsInDb: freezed == otherLanguageEditionsInDb ? _self.otherLanguageEditionsInDb : otherLanguageEditionsInDb // ignore: cast_nullable_to_non_nullable
as List<OtherLanguageEditionsInDb>?,translationInfo: freezed == translationInfo ? _self.translationInfo : translationInfo // ignore: cast_nullable_to_non_nullable
as TranslationInfo?,workAttributes: freezed == workAttributes ? _self.workAttributes : workAttributes // ignore: cast_nullable_to_non_nullable
as String?,ageCategoryString: freezed == ageCategoryString ? _self.ageCategoryString : ageCategoryString // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,userRating: freezed == userRating ? _self.userRating : userRating // ignore: cast_nullable_to_non_nullable
as dynamic,circle: freezed == circle ? _self.circle : circle // ignore: cast_nullable_to_non_nullable
as Circle?,samCoverUrl: freezed == samCoverUrl ? _self.samCoverUrl : samCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailCoverUrl: freezed == thumbnailCoverUrl ? _self.thumbnailCoverUrl : thumbnailCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,mainCoverUrl: freezed == mainCoverUrl ? _self.mainCoverUrl : mainCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationInfoCopyWith<$Res>? get translationInfo {
    if (_self.translationInfo == null) {
    return null;
  }

  return $TranslationInfoCopyWith<$Res>(_self.translationInfo!, (value) {
    return _then(_self.copyWith(translationInfo: value));
  });
}/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleCopyWith<$Res>? get circle {
    if (_self.circle == null) {
    return null;
  }

  return $CircleCopyWith<$Res>(_self.circle!, (value) {
    return _then(_self.copyWith(circle: value));
  });
}
}


/// Adds pattern-matching-related methods to [Work].
extension WorkPatterns on Work {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Work value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Work() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Work value)  $default,){
final _that = this;
switch (_that) {
case _Work():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Work value)?  $default,){
final _that = this;
switch (_that) {
case _Work() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String? title, @JsonKey(name: 'circle_id')  int? circleId,  String? name,  bool? nsfw,  String? release, @JsonKey(name: 'dl_count')  int? dlCount,  int? price, @JsonKey(name: 'review_count')  int? reviewCount, @JsonKey(name: 'rate_count')  int? rateCount, @JsonKey(name: 'rate_average_2dp')  int? rateAverage2dp, @JsonKey(name: 'rate_count_detail')  List<dynamic>? rateCountDetail,  dynamic rank, @JsonKey(name: 'has_subtitle')  bool? hasSubtitle, @JsonKey(name: 'create_date')  String? createDate,  List<dynamic>? vas,  List<Tag>? tags, @JsonKey(name: 'language_editions')  List<LanguageEdition>? languageEditions, @JsonKey(name: 'original_workno')  String? originalWorkno, @JsonKey(name: 'other_language_editions_in_db')  List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb, @JsonKey(name: 'translation_info')  TranslationInfo? translationInfo, @JsonKey(name: 'work_attributes')  String? workAttributes, @JsonKey(name: 'age_category_string')  String? ageCategoryString,  int? duration, @JsonKey(name: 'source_type')  String? sourceType, @JsonKey(name: 'source_id')  String? sourceId, @JsonKey(name: 'source_url')  String? sourceUrl,  dynamic userRating,  Circle? circle,  String? samCoverUrl,  String? thumbnailCoverUrl,  String? mainCoverUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Work() when $default != null:
return $default(_that.id,_that.title,_that.circleId,_that.name,_that.nsfw,_that.release,_that.dlCount,_that.price,_that.reviewCount,_that.rateCount,_that.rateAverage2dp,_that.rateCountDetail,_that.rank,_that.hasSubtitle,_that.createDate,_that.vas,_that.tags,_that.languageEditions,_that.originalWorkno,_that.otherLanguageEditionsInDb,_that.translationInfo,_that.workAttributes,_that.ageCategoryString,_that.duration,_that.sourceType,_that.sourceId,_that.sourceUrl,_that.userRating,_that.circle,_that.samCoverUrl,_that.thumbnailCoverUrl,_that.mainCoverUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String? title, @JsonKey(name: 'circle_id')  int? circleId,  String? name,  bool? nsfw,  String? release, @JsonKey(name: 'dl_count')  int? dlCount,  int? price, @JsonKey(name: 'review_count')  int? reviewCount, @JsonKey(name: 'rate_count')  int? rateCount, @JsonKey(name: 'rate_average_2dp')  int? rateAverage2dp, @JsonKey(name: 'rate_count_detail')  List<dynamic>? rateCountDetail,  dynamic rank, @JsonKey(name: 'has_subtitle')  bool? hasSubtitle, @JsonKey(name: 'create_date')  String? createDate,  List<dynamic>? vas,  List<Tag>? tags, @JsonKey(name: 'language_editions')  List<LanguageEdition>? languageEditions, @JsonKey(name: 'original_workno')  String? originalWorkno, @JsonKey(name: 'other_language_editions_in_db')  List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb, @JsonKey(name: 'translation_info')  TranslationInfo? translationInfo, @JsonKey(name: 'work_attributes')  String? workAttributes, @JsonKey(name: 'age_category_string')  String? ageCategoryString,  int? duration, @JsonKey(name: 'source_type')  String? sourceType, @JsonKey(name: 'source_id')  String? sourceId, @JsonKey(name: 'source_url')  String? sourceUrl,  dynamic userRating,  Circle? circle,  String? samCoverUrl,  String? thumbnailCoverUrl,  String? mainCoverUrl)  $default,) {final _that = this;
switch (_that) {
case _Work():
return $default(_that.id,_that.title,_that.circleId,_that.name,_that.nsfw,_that.release,_that.dlCount,_that.price,_that.reviewCount,_that.rateCount,_that.rateAverage2dp,_that.rateCountDetail,_that.rank,_that.hasSubtitle,_that.createDate,_that.vas,_that.tags,_that.languageEditions,_that.originalWorkno,_that.otherLanguageEditionsInDb,_that.translationInfo,_that.workAttributes,_that.ageCategoryString,_that.duration,_that.sourceType,_that.sourceId,_that.sourceUrl,_that.userRating,_that.circle,_that.samCoverUrl,_that.thumbnailCoverUrl,_that.mainCoverUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String? title, @JsonKey(name: 'circle_id')  int? circleId,  String? name,  bool? nsfw,  String? release, @JsonKey(name: 'dl_count')  int? dlCount,  int? price, @JsonKey(name: 'review_count')  int? reviewCount, @JsonKey(name: 'rate_count')  int? rateCount, @JsonKey(name: 'rate_average_2dp')  int? rateAverage2dp, @JsonKey(name: 'rate_count_detail')  List<dynamic>? rateCountDetail,  dynamic rank, @JsonKey(name: 'has_subtitle')  bool? hasSubtitle, @JsonKey(name: 'create_date')  String? createDate,  List<dynamic>? vas,  List<Tag>? tags, @JsonKey(name: 'language_editions')  List<LanguageEdition>? languageEditions, @JsonKey(name: 'original_workno')  String? originalWorkno, @JsonKey(name: 'other_language_editions_in_db')  List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb, @JsonKey(name: 'translation_info')  TranslationInfo? translationInfo, @JsonKey(name: 'work_attributes')  String? workAttributes, @JsonKey(name: 'age_category_string')  String? ageCategoryString,  int? duration, @JsonKey(name: 'source_type')  String? sourceType, @JsonKey(name: 'source_id')  String? sourceId, @JsonKey(name: 'source_url')  String? sourceUrl,  dynamic userRating,  Circle? circle,  String? samCoverUrl,  String? thumbnailCoverUrl,  String? mainCoverUrl)?  $default,) {final _that = this;
switch (_that) {
case _Work() when $default != null:
return $default(_that.id,_that.title,_that.circleId,_that.name,_that.nsfw,_that.release,_that.dlCount,_that.price,_that.reviewCount,_that.rateCount,_that.rateAverage2dp,_that.rateCountDetail,_that.rank,_that.hasSubtitle,_that.createDate,_that.vas,_that.tags,_that.languageEditions,_that.originalWorkno,_that.otherLanguageEditionsInDb,_that.translationInfo,_that.workAttributes,_that.ageCategoryString,_that.duration,_that.sourceType,_that.sourceId,_that.sourceUrl,_that.userRating,_that.circle,_that.samCoverUrl,_that.thumbnailCoverUrl,_that.mainCoverUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Work implements Work {
   _Work({this.id, this.title, @JsonKey(name: 'circle_id') this.circleId, this.name, this.nsfw, this.release, @JsonKey(name: 'dl_count') this.dlCount, this.price, @JsonKey(name: 'review_count') this.reviewCount, @JsonKey(name: 'rate_count') this.rateCount, @JsonKey(name: 'rate_average_2dp') this.rateAverage2dp, @JsonKey(name: 'rate_count_detail') final  List<dynamic>? rateCountDetail, this.rank, @JsonKey(name: 'has_subtitle') this.hasSubtitle, @JsonKey(name: 'create_date') this.createDate, final  List<dynamic>? vas, final  List<Tag>? tags, @JsonKey(name: 'language_editions') final  List<LanguageEdition>? languageEditions, @JsonKey(name: 'original_workno') this.originalWorkno, @JsonKey(name: 'other_language_editions_in_db') final  List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb, @JsonKey(name: 'translation_info') this.translationInfo, @JsonKey(name: 'work_attributes') this.workAttributes, @JsonKey(name: 'age_category_string') this.ageCategoryString, this.duration, @JsonKey(name: 'source_type') this.sourceType, @JsonKey(name: 'source_id') this.sourceId, @JsonKey(name: 'source_url') this.sourceUrl, this.userRating, this.circle, this.samCoverUrl, this.thumbnailCoverUrl, this.mainCoverUrl}): _rateCountDetail = rateCountDetail,_vas = vas,_tags = tags,_languageEditions = languageEditions,_otherLanguageEditionsInDb = otherLanguageEditionsInDb;
  factory _Work.fromJson(Map<String, dynamic> json) => _$WorkFromJson(json);

@override final  int? id;
@override final  String? title;
@override@JsonKey(name: 'circle_id') final  int? circleId;
@override final  String? name;
@override final  bool? nsfw;
@override final  String? release;
@override@JsonKey(name: 'dl_count') final  int? dlCount;
@override final  int? price;
@override@JsonKey(name: 'review_count') final  int? reviewCount;
@override@JsonKey(name: 'rate_count') final  int? rateCount;
@override@JsonKey(name: 'rate_average_2dp') final  int? rateAverage2dp;
 final  List<dynamic>? _rateCountDetail;
@override@JsonKey(name: 'rate_count_detail') List<dynamic>? get rateCountDetail {
  final value = _rateCountDetail;
  if (value == null) return null;
  if (_rateCountDetail is EqualUnmodifiableListView) return _rateCountDetail;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  dynamic rank;
@override@JsonKey(name: 'has_subtitle') final  bool? hasSubtitle;
@override@JsonKey(name: 'create_date') final  String? createDate;
 final  List<dynamic>? _vas;
@override List<dynamic>? get vas {
  final value = _vas;
  if (value == null) return null;
  if (_vas is EqualUnmodifiableListView) return _vas;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Tag>? _tags;
@override List<Tag>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<LanguageEdition>? _languageEditions;
@override@JsonKey(name: 'language_editions') List<LanguageEdition>? get languageEditions {
  final value = _languageEditions;
  if (value == null) return null;
  if (_languageEditions is EqualUnmodifiableListView) return _languageEditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'original_workno') final  String? originalWorkno;
 final  List<OtherLanguageEditionsInDb>? _otherLanguageEditionsInDb;
@override@JsonKey(name: 'other_language_editions_in_db') List<OtherLanguageEditionsInDb>? get otherLanguageEditionsInDb {
  final value = _otherLanguageEditionsInDb;
  if (value == null) return null;
  if (_otherLanguageEditionsInDb is EqualUnmodifiableListView) return _otherLanguageEditionsInDb;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'translation_info') final  TranslationInfo? translationInfo;
@override@JsonKey(name: 'work_attributes') final  String? workAttributes;
@override@JsonKey(name: 'age_category_string') final  String? ageCategoryString;
@override final  int? duration;
@override@JsonKey(name: 'source_type') final  String? sourceType;
@override@JsonKey(name: 'source_id') final  String? sourceId;
@override@JsonKey(name: 'source_url') final  String? sourceUrl;
@override final  dynamic userRating;
@override final  Circle? circle;
@override final  String? samCoverUrl;
@override final  String? thumbnailCoverUrl;
@override final  String? mainCoverUrl;

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkCopyWith<_Work> get copyWith => __$WorkCopyWithImpl<_Work>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Work&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.circleId, circleId) || other.circleId == circleId)&&(identical(other.name, name) || other.name == name)&&(identical(other.nsfw, nsfw) || other.nsfw == nsfw)&&(identical(other.release, release) || other.release == release)&&(identical(other.dlCount, dlCount) || other.dlCount == dlCount)&&(identical(other.price, price) || other.price == price)&&(identical(other.reviewCount, reviewCount) || other.reviewCount == reviewCount)&&(identical(other.rateCount, rateCount) || other.rateCount == rateCount)&&(identical(other.rateAverage2dp, rateAverage2dp) || other.rateAverage2dp == rateAverage2dp)&&const DeepCollectionEquality().equals(other._rateCountDetail, _rateCountDetail)&&const DeepCollectionEquality().equals(other.rank, rank)&&(identical(other.hasSubtitle, hasSubtitle) || other.hasSubtitle == hasSubtitle)&&(identical(other.createDate, createDate) || other.createDate == createDate)&&const DeepCollectionEquality().equals(other._vas, _vas)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._languageEditions, _languageEditions)&&(identical(other.originalWorkno, originalWorkno) || other.originalWorkno == originalWorkno)&&const DeepCollectionEquality().equals(other._otherLanguageEditionsInDb, _otherLanguageEditionsInDb)&&(identical(other.translationInfo, translationInfo) || other.translationInfo == translationInfo)&&(identical(other.workAttributes, workAttributes) || other.workAttributes == workAttributes)&&(identical(other.ageCategoryString, ageCategoryString) || other.ageCategoryString == ageCategoryString)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.sourceType, sourceType) || other.sourceType == sourceType)&&(identical(other.sourceId, sourceId) || other.sourceId == sourceId)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&const DeepCollectionEquality().equals(other.userRating, userRating)&&(identical(other.circle, circle) || other.circle == circle)&&(identical(other.samCoverUrl, samCoverUrl) || other.samCoverUrl == samCoverUrl)&&(identical(other.thumbnailCoverUrl, thumbnailCoverUrl) || other.thumbnailCoverUrl == thumbnailCoverUrl)&&(identical(other.mainCoverUrl, mainCoverUrl) || other.mainCoverUrl == mainCoverUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,circleId,name,nsfw,release,dlCount,price,reviewCount,rateCount,rateAverage2dp,const DeepCollectionEquality().hash(_rateCountDetail),const DeepCollectionEquality().hash(rank),hasSubtitle,createDate,const DeepCollectionEquality().hash(_vas),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_languageEditions),originalWorkno,const DeepCollectionEquality().hash(_otherLanguageEditionsInDb),translationInfo,workAttributes,ageCategoryString,duration,sourceType,sourceId,sourceUrl,const DeepCollectionEquality().hash(userRating),circle,samCoverUrl,thumbnailCoverUrl,mainCoverUrl]);

@override
String toString() {
  return 'Work(id: $id, title: $title, circleId: $circleId, name: $name, nsfw: $nsfw, release: $release, dlCount: $dlCount, price: $price, reviewCount: $reviewCount, rateCount: $rateCount, rateAverage2dp: $rateAverage2dp, rateCountDetail: $rateCountDetail, rank: $rank, hasSubtitle: $hasSubtitle, createDate: $createDate, vas: $vas, tags: $tags, languageEditions: $languageEditions, originalWorkno: $originalWorkno, otherLanguageEditionsInDb: $otherLanguageEditionsInDb, translationInfo: $translationInfo, workAttributes: $workAttributes, ageCategoryString: $ageCategoryString, duration: $duration, sourceType: $sourceType, sourceId: $sourceId, sourceUrl: $sourceUrl, userRating: $userRating, circle: $circle, samCoverUrl: $samCoverUrl, thumbnailCoverUrl: $thumbnailCoverUrl, mainCoverUrl: $mainCoverUrl)';
}


}

/// @nodoc
abstract mixin class _$WorkCopyWith<$Res> implements $WorkCopyWith<$Res> {
  factory _$WorkCopyWith(_Work value, $Res Function(_Work) _then) = __$WorkCopyWithImpl;
@override @useResult
$Res call({
 int? id, String? title,@JsonKey(name: 'circle_id') int? circleId, String? name, bool? nsfw, String? release,@JsonKey(name: 'dl_count') int? dlCount, int? price,@JsonKey(name: 'review_count') int? reviewCount,@JsonKey(name: 'rate_count') int? rateCount,@JsonKey(name: 'rate_average_2dp') int? rateAverage2dp,@JsonKey(name: 'rate_count_detail') List<dynamic>? rateCountDetail, dynamic rank,@JsonKey(name: 'has_subtitle') bool? hasSubtitle,@JsonKey(name: 'create_date') String? createDate, List<dynamic>? vas, List<Tag>? tags,@JsonKey(name: 'language_editions') List<LanguageEdition>? languageEditions,@JsonKey(name: 'original_workno') String? originalWorkno,@JsonKey(name: 'other_language_editions_in_db') List<OtherLanguageEditionsInDb>? otherLanguageEditionsInDb,@JsonKey(name: 'translation_info') TranslationInfo? translationInfo,@JsonKey(name: 'work_attributes') String? workAttributes,@JsonKey(name: 'age_category_string') String? ageCategoryString, int? duration,@JsonKey(name: 'source_type') String? sourceType,@JsonKey(name: 'source_id') String? sourceId,@JsonKey(name: 'source_url') String? sourceUrl, dynamic userRating, Circle? circle, String? samCoverUrl, String? thumbnailCoverUrl, String? mainCoverUrl
});


@override $TranslationInfoCopyWith<$Res>? get translationInfo;@override $CircleCopyWith<$Res>? get circle;

}
/// @nodoc
class __$WorkCopyWithImpl<$Res>
    implements _$WorkCopyWith<$Res> {
  __$WorkCopyWithImpl(this._self, this._then);

  final _Work _self;
  final $Res Function(_Work) _then;

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? circleId = freezed,Object? name = freezed,Object? nsfw = freezed,Object? release = freezed,Object? dlCount = freezed,Object? price = freezed,Object? reviewCount = freezed,Object? rateCount = freezed,Object? rateAverage2dp = freezed,Object? rateCountDetail = freezed,Object? rank = freezed,Object? hasSubtitle = freezed,Object? createDate = freezed,Object? vas = freezed,Object? tags = freezed,Object? languageEditions = freezed,Object? originalWorkno = freezed,Object? otherLanguageEditionsInDb = freezed,Object? translationInfo = freezed,Object? workAttributes = freezed,Object? ageCategoryString = freezed,Object? duration = freezed,Object? sourceType = freezed,Object? sourceId = freezed,Object? sourceUrl = freezed,Object? userRating = freezed,Object? circle = freezed,Object? samCoverUrl = freezed,Object? thumbnailCoverUrl = freezed,Object? mainCoverUrl = freezed,}) {
  return _then(_Work(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,circleId: freezed == circleId ? _self.circleId : circleId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,nsfw: freezed == nsfw ? _self.nsfw : nsfw // ignore: cast_nullable_to_non_nullable
as bool?,release: freezed == release ? _self.release : release // ignore: cast_nullable_to_non_nullable
as String?,dlCount: freezed == dlCount ? _self.dlCount : dlCount // ignore: cast_nullable_to_non_nullable
as int?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int?,reviewCount: freezed == reviewCount ? _self.reviewCount : reviewCount // ignore: cast_nullable_to_non_nullable
as int?,rateCount: freezed == rateCount ? _self.rateCount : rateCount // ignore: cast_nullable_to_non_nullable
as int?,rateAverage2dp: freezed == rateAverage2dp ? _self.rateAverage2dp : rateAverage2dp // ignore: cast_nullable_to_non_nullable
as int?,rateCountDetail: freezed == rateCountDetail ? _self._rateCountDetail : rateCountDetail // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,rank: freezed == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as dynamic,hasSubtitle: freezed == hasSubtitle ? _self.hasSubtitle : hasSubtitle // ignore: cast_nullable_to_non_nullable
as bool?,createDate: freezed == createDate ? _self.createDate : createDate // ignore: cast_nullable_to_non_nullable
as String?,vas: freezed == vas ? _self._vas : vas // ignore: cast_nullable_to_non_nullable
as List<dynamic>?,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<Tag>?,languageEditions: freezed == languageEditions ? _self._languageEditions : languageEditions // ignore: cast_nullable_to_non_nullable
as List<LanguageEdition>?,originalWorkno: freezed == originalWorkno ? _self.originalWorkno : originalWorkno // ignore: cast_nullable_to_non_nullable
as String?,otherLanguageEditionsInDb: freezed == otherLanguageEditionsInDb ? _self._otherLanguageEditionsInDb : otherLanguageEditionsInDb // ignore: cast_nullable_to_non_nullable
as List<OtherLanguageEditionsInDb>?,translationInfo: freezed == translationInfo ? _self.translationInfo : translationInfo // ignore: cast_nullable_to_non_nullable
as TranslationInfo?,workAttributes: freezed == workAttributes ? _self.workAttributes : workAttributes // ignore: cast_nullable_to_non_nullable
as String?,ageCategoryString: freezed == ageCategoryString ? _self.ageCategoryString : ageCategoryString // ignore: cast_nullable_to_non_nullable
as String?,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int?,sourceType: freezed == sourceType ? _self.sourceType : sourceType // ignore: cast_nullable_to_non_nullable
as String?,sourceId: freezed == sourceId ? _self.sourceId : sourceId // ignore: cast_nullable_to_non_nullable
as String?,sourceUrl: freezed == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String?,userRating: freezed == userRating ? _self.userRating : userRating // ignore: cast_nullable_to_non_nullable
as dynamic,circle: freezed == circle ? _self.circle : circle // ignore: cast_nullable_to_non_nullable
as Circle?,samCoverUrl: freezed == samCoverUrl ? _self.samCoverUrl : samCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,thumbnailCoverUrl: freezed == thumbnailCoverUrl ? _self.thumbnailCoverUrl : thumbnailCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,mainCoverUrl: freezed == mainCoverUrl ? _self.mainCoverUrl : mainCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TranslationInfoCopyWith<$Res>? get translationInfo {
    if (_self.translationInfo == null) {
    return null;
  }

  return $TranslationInfoCopyWith<$Res>(_self.translationInfo!, (value) {
    return _then(_self.copyWith(translationInfo: value));
  });
}/// Create a copy of Work
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CircleCopyWith<$Res>? get circle {
    if (_self.circle == null) {
    return null;
  }

  return $CircleCopyWith<$Res>(_self.circle!, (value) {
    return _then(_self.copyWith(circle: value));
  });
}
}

// dart format on
