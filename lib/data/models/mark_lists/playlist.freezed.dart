// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Playlist {

 String? get id;@JsonKey(name: 'user_name') String? get userName; int? get privacy; String? get locale;@JsonKey(name: 'playback_count') int? get playbackCount; String? get name; String? get description;@JsonKey(name: 'created_at') String? get createdAt;@JsonKey(name: 'updated_at') String? get updatedAt;@JsonKey(name: 'works_count') int? get worksCount;@JsonKey(name: 'latestWorkID') dynamic get latestWorkId; String? get mainCoverUrl;
/// Create a copy of Playlist
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaylistCopyWith<Playlist> get copyWith => _$PlaylistCopyWithImpl<Playlist>(this as Playlist, _$identity);

  /// Serializes this Playlist to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Playlist&&(identical(other.id, id) || other.id == id)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.playbackCount, playbackCount) || other.playbackCount == playbackCount)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.worksCount, worksCount) || other.worksCount == worksCount)&&const DeepCollectionEquality().equals(other.latestWorkId, latestWorkId)&&(identical(other.mainCoverUrl, mainCoverUrl) || other.mainCoverUrl == mainCoverUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userName,privacy,locale,playbackCount,name,description,createdAt,updatedAt,worksCount,const DeepCollectionEquality().hash(latestWorkId),mainCoverUrl);

@override
String toString() {
  return 'Playlist(id: $id, userName: $userName, privacy: $privacy, locale: $locale, playbackCount: $playbackCount, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, worksCount: $worksCount, latestWorkId: $latestWorkId, mainCoverUrl: $mainCoverUrl)';
}


}

/// @nodoc
abstract mixin class $PlaylistCopyWith<$Res>  {
  factory $PlaylistCopyWith(Playlist value, $Res Function(Playlist) _then) = _$PlaylistCopyWithImpl;
@useResult
$Res call({
 String? id,@JsonKey(name: 'user_name') String? userName, int? privacy, String? locale,@JsonKey(name: 'playback_count') int? playbackCount, String? name, String? description,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'works_count') int? worksCount,@JsonKey(name: 'latestWorkID') dynamic latestWorkId, String? mainCoverUrl
});




}
/// @nodoc
class _$PlaylistCopyWithImpl<$Res>
    implements $PlaylistCopyWith<$Res> {
  _$PlaylistCopyWithImpl(this._self, this._then);

  final Playlist _self;
  final $Res Function(Playlist) _then;

/// Create a copy of Playlist
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userName = freezed,Object? privacy = freezed,Object? locale = freezed,Object? playbackCount = freezed,Object? name = freezed,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? worksCount = freezed,Object? latestWorkId = freezed,Object? mainCoverUrl = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,privacy: freezed == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as int?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,playbackCount: freezed == playbackCount ? _self.playbackCount : playbackCount // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,worksCount: freezed == worksCount ? _self.worksCount : worksCount // ignore: cast_nullable_to_non_nullable
as int?,latestWorkId: freezed == latestWorkId ? _self.latestWorkId : latestWorkId // ignore: cast_nullable_to_non_nullable
as dynamic,mainCoverUrl: freezed == mainCoverUrl ? _self.mainCoverUrl : mainCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Playlist].
extension PlaylistPatterns on Playlist {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Playlist value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Playlist() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Playlist value)  $default,){
final _that = this;
switch (_that) {
case _Playlist():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Playlist value)?  $default,){
final _that = this;
switch (_that) {
case _Playlist() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_name')  String? userName,  int? privacy,  String? locale, @JsonKey(name: 'playback_count')  int? playbackCount,  String? name,  String? description, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'works_count')  int? worksCount, @JsonKey(name: 'latestWorkID')  dynamic latestWorkId,  String? mainCoverUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Playlist() when $default != null:
return $default(_that.id,_that.userName,_that.privacy,_that.locale,_that.playbackCount,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.worksCount,_that.latestWorkId,_that.mainCoverUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id, @JsonKey(name: 'user_name')  String? userName,  int? privacy,  String? locale, @JsonKey(name: 'playback_count')  int? playbackCount,  String? name,  String? description, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'works_count')  int? worksCount, @JsonKey(name: 'latestWorkID')  dynamic latestWorkId,  String? mainCoverUrl)  $default,) {final _that = this;
switch (_that) {
case _Playlist():
return $default(_that.id,_that.userName,_that.privacy,_that.locale,_that.playbackCount,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.worksCount,_that.latestWorkId,_that.mainCoverUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id, @JsonKey(name: 'user_name')  String? userName,  int? privacy,  String? locale, @JsonKey(name: 'playback_count')  int? playbackCount,  String? name,  String? description, @JsonKey(name: 'created_at')  String? createdAt, @JsonKey(name: 'updated_at')  String? updatedAt, @JsonKey(name: 'works_count')  int? worksCount, @JsonKey(name: 'latestWorkID')  dynamic latestWorkId,  String? mainCoverUrl)?  $default,) {final _that = this;
switch (_that) {
case _Playlist() when $default != null:
return $default(_that.id,_that.userName,_that.privacy,_that.locale,_that.playbackCount,_that.name,_that.description,_that.createdAt,_that.updatedAt,_that.worksCount,_that.latestWorkId,_that.mainCoverUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Playlist implements Playlist {
   _Playlist({this.id, @JsonKey(name: 'user_name') this.userName, this.privacy, this.locale, @JsonKey(name: 'playback_count') this.playbackCount, this.name, this.description, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'works_count') this.worksCount, @JsonKey(name: 'latestWorkID') this.latestWorkId, this.mainCoverUrl});
  factory _Playlist.fromJson(Map<String, dynamic> json) => _$PlaylistFromJson(json);

@override final  String? id;
@override@JsonKey(name: 'user_name') final  String? userName;
@override final  int? privacy;
@override final  String? locale;
@override@JsonKey(name: 'playback_count') final  int? playbackCount;
@override final  String? name;
@override final  String? description;
@override@JsonKey(name: 'created_at') final  String? createdAt;
@override@JsonKey(name: 'updated_at') final  String? updatedAt;
@override@JsonKey(name: 'works_count') final  int? worksCount;
@override@JsonKey(name: 'latestWorkID') final  dynamic latestWorkId;
@override final  String? mainCoverUrl;

/// Create a copy of Playlist
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaylistCopyWith<_Playlist> get copyWith => __$PlaylistCopyWithImpl<_Playlist>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaylistToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Playlist&&(identical(other.id, id) || other.id == id)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.playbackCount, playbackCount) || other.playbackCount == playbackCount)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.worksCount, worksCount) || other.worksCount == worksCount)&&const DeepCollectionEquality().equals(other.latestWorkId, latestWorkId)&&(identical(other.mainCoverUrl, mainCoverUrl) || other.mainCoverUrl == mainCoverUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userName,privacy,locale,playbackCount,name,description,createdAt,updatedAt,worksCount,const DeepCollectionEquality().hash(latestWorkId),mainCoverUrl);

@override
String toString() {
  return 'Playlist(id: $id, userName: $userName, privacy: $privacy, locale: $locale, playbackCount: $playbackCount, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, worksCount: $worksCount, latestWorkId: $latestWorkId, mainCoverUrl: $mainCoverUrl)';
}


}

/// @nodoc
abstract mixin class _$PlaylistCopyWith<$Res> implements $PlaylistCopyWith<$Res> {
  factory _$PlaylistCopyWith(_Playlist value, $Res Function(_Playlist) _then) = __$PlaylistCopyWithImpl;
@override @useResult
$Res call({
 String? id,@JsonKey(name: 'user_name') String? userName, int? privacy, String? locale,@JsonKey(name: 'playback_count') int? playbackCount, String? name, String? description,@JsonKey(name: 'created_at') String? createdAt,@JsonKey(name: 'updated_at') String? updatedAt,@JsonKey(name: 'works_count') int? worksCount,@JsonKey(name: 'latestWorkID') dynamic latestWorkId, String? mainCoverUrl
});




}
/// @nodoc
class __$PlaylistCopyWithImpl<$Res>
    implements _$PlaylistCopyWith<$Res> {
  __$PlaylistCopyWithImpl(this._self, this._then);

  final _Playlist _self;
  final $Res Function(_Playlist) _then;

/// Create a copy of Playlist
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userName = freezed,Object? privacy = freezed,Object? locale = freezed,Object? playbackCount = freezed,Object? name = freezed,Object? description = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? worksCount = freezed,Object? latestWorkId = freezed,Object? mainCoverUrl = freezed,}) {
  return _then(_Playlist(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userName: freezed == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String?,privacy: freezed == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as int?,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,playbackCount: freezed == playbackCount ? _self.playbackCount : playbackCount // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,worksCount: freezed == worksCount ? _self.worksCount : worksCount // ignore: cast_nullable_to_non_nullable
as int?,latestWorkId: freezed == latestWorkId ? _self.latestWorkId : latestWorkId // ignore: cast_nullable_to_non_nullable
as dynamic,mainCoverUrl: freezed == mainCoverUrl ? _self.mainCoverUrl : mainCoverUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
