import 'package:asmrapp/core/audio/events/playback_event_hub.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:asmrapp/utils/logger.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _player;
  final PlaybackEventHub _eventHub;

  AudioPlayerHandler(this._player, this._eventHub) {
    AppLogger.debug('AudioPlayerHandler 初始化');

    // 改为监听 EventHub
    _eventHub.playbackState.listen((event) {
      final state = PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          event.state.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 2],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[event.state.processingState]!,
        playing: event.state.playing,
        updatePosition: event.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: 0,
      );
      playbackState.add(state);
    });
  }

  @override
  Future<void> play() async {
    AppLogger.debug('AudioHandler: 播放命令');
    _player.play();
  }

  @override
  Future<void> pause() async {
    AppLogger.debug('AudioHandler: 暂停命令');
    _player.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    AppLogger.debug('AudioHandler: 跳转命令 position=$position');
    await _player.seek(position);
  }

  @override
  Future<void> stop() async {
    AppLogger.debug('AudioHandler: 停止命令');
    await _player.stop();
  }
}
