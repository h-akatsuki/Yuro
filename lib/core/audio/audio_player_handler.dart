import 'dart:async';

import 'package:asmrapp/core/audio/events/playback_event_hub.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:asmrapp/utils/logger.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _player;
  final PlaybackEventHub _eventHub;
  final Future<void> Function() _onPlay;
  final Future<void> Function() _onPause;
  final Future<void> Function() _onStop;
  final Future<void> Function(Duration position) _onSeek;
  final Future<void> Function() _onPrevious;
  final Future<void> Function() _onNext;
  final List<StreamSubscription> _subscriptions = [];

  late PlayerState _latestState;
  Duration _latestPosition = Duration.zero;
  Duration _latestBufferedPosition = Duration.zero;

  AudioPlayerHandler({
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
       _onNext = onNext {
    AppLogger.debug('AudioPlayerHandler 初始化');
    _latestState = _player.playerState;

    _subscriptions.add(
      _eventHub.playbackState.listen((event) {
        _latestState = event.state;
        _latestPosition = event.position;
        _broadcastState();
      }),
    );
    // Spotube と同様、position/buffer の更新でも OS 側の状態を同期する。
    _subscriptions.add(
      _eventHub.playbackProgress.listen((event) {
        _latestPosition = event.position;
        _latestBufferedPosition = event.bufferedPosition;
        _broadcastState();
      }),
    );
  }

  void _broadcastState() {
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          _latestState.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0, 1, 2],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_latestState.processingState]!,
        playing: _latestState.playing,
        updatePosition: _latestPosition,
        bufferedPosition: _latestBufferedPosition,
        speed: _player.speed,
        queueIndex: _player.currentIndex,
      ),
    );
  }

  @override
  Future<void> play() async {
    AppLogger.debug('AudioHandler: 播放命令');
    await _onPlay();
  }

  @override
  Future<void> pause() async {
    AppLogger.debug('AudioHandler: 暂停命令');
    await _onPause();
  }

  @override
  Future<void> seek(Duration position) async {
    AppLogger.debug('AudioHandler: 跳转命令 position=$position');
    await _onSeek(position);
  }

  @override
  Future<void> stop() async {
    AppLogger.debug('AudioHandler: 停止命令');
    await _onStop();
  }

  @override
  Future<void> skipToPrevious() async {
    AppLogger.debug('AudioHandler: 上一曲命令');
    await _onPrevious();
  }

  @override
  Future<void> skipToNext() async {
    AppLogger.debug('AudioHandler: 下一曲命令');
    await _onNext();
  }

  Future<void> disposeHandler() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
  }
}
