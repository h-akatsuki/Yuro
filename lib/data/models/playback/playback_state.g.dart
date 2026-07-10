// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playback_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaybackState _$PlaybackStateFromJson(Map<String, dynamic> json) =>
    _PlaybackState(
      work: Work.fromJson(json['work'] as Map<String, dynamic>),
      files: Files.fromJson(json['files'] as Map<String, dynamic>),
      currentFile: Child.fromJson(json['currentFile'] as Map<String, dynamic>),
      playlist: (json['playlist'] as List<dynamic>)
          .map((e) => Child.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentIndex: (json['currentIndex'] as num).toInt(),
      playMode: $enumDecode(_$PlayModeEnumMap, json['playMode']),
      position: (json['position'] as num).toInt(),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$PlaybackStateToJson(_PlaybackState instance) =>
    <String, dynamic>{
      'work': instance.work,
      'files': instance.files,
      'currentFile': instance.currentFile,
      'playlist': instance.playlist,
      'currentIndex': instance.currentIndex,
      'playMode': _$PlayModeEnumMap[instance.playMode]!,
      'position': instance.position,
      'timestamp': instance.timestamp,
    };

const _$PlayModeEnumMap = {
  PlayMode.single: 'single',
  PlayMode.loop: 'loop',
  PlayMode.sequence: 'sequence',
};
