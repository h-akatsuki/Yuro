// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playback_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaybackState {

 Work get work; Files get files; Child get currentFile; List<Child> get playlist; int get currentIndex; PlayMode get playMode; int get position;// 使用毫秒存储
 String get timestamp;
/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaybackStateCopyWith<PlaybackState> get copyWith => _$PlaybackStateCopyWithImpl<PlaybackState>(this as PlaybackState, _$identity);

  /// Serializes this PlaybackState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaybackState&&(identical(other.work, work) || other.work == work)&&(identical(other.files, files) || other.files == files)&&(identical(other.currentFile, currentFile) || other.currentFile == currentFile)&&const DeepCollectionEquality().equals(other.playlist, playlist)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.playMode, playMode) || other.playMode == playMode)&&(identical(other.position, position) || other.position == position)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,work,files,currentFile,const DeepCollectionEquality().hash(playlist),currentIndex,playMode,position,timestamp);

@override
String toString() {
  return 'PlaybackState(work: $work, files: $files, currentFile: $currentFile, playlist: $playlist, currentIndex: $currentIndex, playMode: $playMode, position: $position, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $PlaybackStateCopyWith<$Res>  {
  factory $PlaybackStateCopyWith(PlaybackState value, $Res Function(PlaybackState) _then) = _$PlaybackStateCopyWithImpl;
@useResult
$Res call({
 Work work, Files files, Child currentFile, List<Child> playlist, int currentIndex, PlayMode playMode, int position, String timestamp
});


$WorkCopyWith<$Res> get work;$FilesCopyWith<$Res> get files;$ChildCopyWith<$Res> get currentFile;

}
/// @nodoc
class _$PlaybackStateCopyWithImpl<$Res>
    implements $PlaybackStateCopyWith<$Res> {
  _$PlaybackStateCopyWithImpl(this._self, this._then);

  final PlaybackState _self;
  final $Res Function(PlaybackState) _then;

/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? work = null,Object? files = null,Object? currentFile = null,Object? playlist = null,Object? currentIndex = null,Object? playMode = null,Object? position = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
work: null == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as Work,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as Files,currentFile: null == currentFile ? _self.currentFile : currentFile // ignore: cast_nullable_to_non_nullable
as Child,playlist: null == playlist ? _self.playlist : playlist // ignore: cast_nullable_to_non_nullable
as List<Child>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,playMode: null == playMode ? _self.playMode : playMode // ignore: cast_nullable_to_non_nullable
as PlayMode,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkCopyWith<$Res> get work {

  return $WorkCopyWith<$Res>(_self.work, (value) {
    return _then(_self.copyWith(work: value));
  });
}/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilesCopyWith<$Res> get files {

  return $FilesCopyWith<$Res>(_self.files, (value) {
    return _then(_self.copyWith(files: value));
  });
}/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildCopyWith<$Res> get currentFile {

  return $ChildCopyWith<$Res>(_self.currentFile, (value) {
    return _then(_self.copyWith(currentFile: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlaybackState].
extension PlaybackStatePatterns on PlaybackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaybackState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaybackState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaybackState value)  $default,){
final _that = this;
switch (_that) {
case _PlaybackState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaybackState value)?  $default,){
final _that = this;
switch (_that) {
case _PlaybackState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Work work,  Files files,  Child currentFile,  List<Child> playlist,  int currentIndex,  PlayMode playMode,  int position,  String timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaybackState() when $default != null:
return $default(_that.work,_that.files,_that.currentFile,_that.playlist,_that.currentIndex,_that.playMode,_that.position,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Work work,  Files files,  Child currentFile,  List<Child> playlist,  int currentIndex,  PlayMode playMode,  int position,  String timestamp)  $default,) {final _that = this;
switch (_that) {
case _PlaybackState():
return $default(_that.work,_that.files,_that.currentFile,_that.playlist,_that.currentIndex,_that.playMode,_that.position,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Work work,  Files files,  Child currentFile,  List<Child> playlist,  int currentIndex,  PlayMode playMode,  int position,  String timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PlaybackState() when $default != null:
return $default(_that.work,_that.files,_that.currentFile,_that.playlist,_that.currentIndex,_that.playMode,_that.position,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaybackState implements PlaybackState {
  const _PlaybackState({required this.work, required this.files, required this.currentFile, required final  List<Child> playlist, required this.currentIndex, required this.playMode, required this.position, required this.timestamp}): _playlist = playlist;
  factory _PlaybackState.fromJson(Map<String, dynamic> json) => _$PlaybackStateFromJson(json);

@override final  Work work;
@override final  Files files;
@override final  Child currentFile;
 final  List<Child> _playlist;
@override List<Child> get playlist {
  if (_playlist is EqualUnmodifiableListView) return _playlist;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playlist);
}

@override final  int currentIndex;
@override final  PlayMode playMode;
@override final  int position;
// 使用毫秒存储
@override final  String timestamp;

/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaybackStateCopyWith<_PlaybackState> get copyWith => __$PlaybackStateCopyWithImpl<_PlaybackState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaybackStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaybackState&&(identical(other.work, work) || other.work == work)&&(identical(other.files, files) || other.files == files)&&(identical(other.currentFile, currentFile) || other.currentFile == currentFile)&&const DeepCollectionEquality().equals(other._playlist, _playlist)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.playMode, playMode) || other.playMode == playMode)&&(identical(other.position, position) || other.position == position)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,work,files,currentFile,const DeepCollectionEquality().hash(_playlist),currentIndex,playMode,position,timestamp);

@override
String toString() {
  return 'PlaybackState(work: $work, files: $files, currentFile: $currentFile, playlist: $playlist, currentIndex: $currentIndex, playMode: $playMode, position: $position, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PlaybackStateCopyWith<$Res> implements $PlaybackStateCopyWith<$Res> {
  factory _$PlaybackStateCopyWith(_PlaybackState value, $Res Function(_PlaybackState) _then) = __$PlaybackStateCopyWithImpl;
@override @useResult
$Res call({
 Work work, Files files, Child currentFile, List<Child> playlist, int currentIndex, PlayMode playMode, int position, String timestamp
});


@override $WorkCopyWith<$Res> get work;@override $FilesCopyWith<$Res> get files;@override $ChildCopyWith<$Res> get currentFile;

}
/// @nodoc
class __$PlaybackStateCopyWithImpl<$Res>
    implements _$PlaybackStateCopyWith<$Res> {
  __$PlaybackStateCopyWithImpl(this._self, this._then);

  final _PlaybackState _self;
  final $Res Function(_PlaybackState) _then;

/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? work = null,Object? files = null,Object? currentFile = null,Object? playlist = null,Object? currentIndex = null,Object? playMode = null,Object? position = null,Object? timestamp = null,}) {
  return _then(_PlaybackState(
work: null == work ? _self.work : work // ignore: cast_nullable_to_non_nullable
as Work,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as Files,currentFile: null == currentFile ? _self.currentFile : currentFile // ignore: cast_nullable_to_non_nullable
as Child,playlist: null == playlist ? _self._playlist : playlist // ignore: cast_nullable_to_non_nullable
as List<Child>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,playMode: null == playMode ? _self.playMode : playMode // ignore: cast_nullable_to_non_nullable
as PlayMode,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WorkCopyWith<$Res> get work {

  return $WorkCopyWith<$Res>(_self.work, (value) {
    return _then(_self.copyWith(work: value));
  });
}/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FilesCopyWith<$Res> get files {

  return $FilesCopyWith<$Res>(_self.files, (value) {
    return _then(_self.copyWith(files: value));
  });
}/// Create a copy of PlaybackState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChildCopyWith<$Res> get currentFile {

  return $ChildCopyWith<$Res>(_self.currentFile, (value) {
    return _then(_self.copyWith(currentFile: value));
  });
}
}

// dart format on
