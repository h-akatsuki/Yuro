import 'dart:async';

import 'package:asmrapp/core/audio/events/playback_event_hub.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:rxdart/rxdart.dart';
import '../models/audio_track_info.dart';
import '../audio_player_handler.dart';

class AudioNotificationService {
  final AudioPlayer _player;
  final PlaybackEventHub _eventHub;
  final Future<void> Function() _onPlay;
  final Future<void> Function() _onPause;
  final Future<void> Function() _onStop;
  final Future<void> Function(Duration position) _onSeek;
  final Future<void> Function() _onPrevious;
  final Future<void> Function() _onNext;
  AudioPlayerHandler? _audioHandler;
  final _mediaItem = BehaviorSubject<MediaItem?>();
  final List<StreamSubscription> _subscriptions = [];

  AudioNotificationService({
    required AudioPlayer player,
    required PlaybackEventHub eventHub,
    required Future<void> Function() onPlay,
    required Future<void> Function() onPause,
    required Future<void> Function() onStop,
    required Future<void> Function(Duration position) onSeek,
    required Future<void> Function() onPrevious,
    required Future<void> Function() onNext,
  }) : _player = player,
       _eventHub = eventHub,
       _onPlay = onPlay,
       _onPause = onPause,
       _onStop = onStop,
       _onSeek = onSeek,
       _onPrevious = onPrevious,
       _onNext = onNext;

  Future<void> init() async {
    try {
      _audioHandler = await AudioService.init<AudioPlayerHandler>(
        builder: () => AudioPlayerHandler(
          player: _player,
          eventHub: _eventHub,
          onPlay: _onPlay,
          onPause: _onPause,
          onStop: _onStop,
          onSeek: _onSeek,
          onPrevious: _onPrevious,
          onNext: _onNext,
        ),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.asmrapp.audio',
          androidNotificationChannelName: 'ASMR One 播放器',
          androidNotificationOngoing: false,
          // Android 12+ でバックグラウンドから foreground service を
          // 再起動できず再生が止まるケースを避ける。
          androidStopForegroundOnPause: false,
        ),
      );

      _setupEventListeners();
      AppLogger.debug('通知栏服务初始化成功');
    } catch (e) {
      AppLogger.error('通知栏服务初始化失败', e);
      rethrow;
    }
  }

  void _setupEventListeners() {
    // 监听轨道变更事件来更新媒体信息
    _subscriptions.add(
      _eventHub.trackChange.listen((event) {
        updateMetadata(event.track);
      }),
    );
  }

  void updateMetadata(AudioTrackInfo trackInfo) {
    final coverUri = Uri.tryParse(trackInfo.coverUrl);
    final mediaItem = MediaItem(
      id: trackInfo.url,
      title: trackInfo.title,
      artist: trackInfo.artist,
      artUri: coverUri?.hasScheme == true ? coverUri : null,
      duration: trackInfo.duration,
    );

    _mediaItem.add(mediaItem);
    _audioHandler?.mediaItem.add(mediaItem);
  }

  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    await _audioHandler?.disposeHandler();
    await _mediaItem.close();
  }
}
