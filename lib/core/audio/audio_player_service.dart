import 'dart:async';

import 'package:asmrapp/utils/logger.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';

import './controllers/playback_controller.dart';
import './events/playback_event_hub.dart';
import './i_audio_player_service.dart';
import './models/audio_track_info.dart';
import './models/playback_context.dart';
import './notification/audio_notification_service.dart';
import './state/playback_state_manager.dart';
import './storage/i_playback_state_repository.dart';
import './utils/audio_error_handler.dart';

class AudioPlayerService implements IAudioPlayerService {
  late final AudioPlayer _player;
  late final AudioNotificationService _notificationService;
  late final PlaybackStateManager _stateManager;
  late final PlaybackController _playbackController;
  final PlaybackEventHub _eventHub;
  final IPlaybackStateRepository _stateRepository;
  int _contextRequest = 0;
  bool _shouldPlay = false;
  bool _disposed = false;

  AudioPlayerService._({
    required PlaybackEventHub eventHub,
    required IPlaybackStateRepository stateRepository,
  }) : _eventHub = eventHub,
       _stateRepository = stateRepository;

  static Future<AudioPlayerService> create({
    required PlaybackEventHub eventHub,
    required IPlaybackStateRepository stateRepository,
  }) async {
    final service = AudioPlayerService._(
      eventHub: eventHub,
      stateRepository: stateRepository,
    );
    await service._init();
    return service;
  }

  Future<void> _init() async {
    try {
      _player = AudioPlayer(
        userAgent: 'Yuro audio player',
        // 壊れた URL が 1 件あってもプレイリスト全体を停止させない。
        maxSkipsOnError: 3,
      );
      _stateManager = PlaybackStateManager(
        player: _player,
        stateRepository: _stateRepository,
        eventHub: _eventHub,
      );

      _playbackController = PlaybackController(
        player: _player,
        stateManager: _stateManager,
      );

      _stateManager.initStateListeners();

      _notificationService = AudioNotificationService(
        player: _player,
        eventHub: _eventHub,
        onPlay: resume,
        onPause: pause,
        onStop: stop,
        onSeek: seek,
        onPrevious: previous,
        onNext: next,
      );
      await _notificationService.init();

      // すべての音声プラグイン初期化後に、アプリの設定を最後に適用する。
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());

      await restorePlaybackState();
    } catch (e, stack) {
      AudioErrorHandler.handleError(AudioErrorType.init, '音频播放器初始化', e, stack);
      AudioErrorHandler.throwError(AudioErrorType.init, '音频播放器初始化', e);
    }
  }

  // 基础播放控制
  @override
  Future<void> pause() async {
    _shouldPlay = false;
    await _playbackController.pause();
  }

  @override
  Future<void> resume() async {
    _shouldPlay = true;
    await _playbackController.play();
  }

  @override
  Future<void> stop() async {
    _contextRequest++;
    _shouldPlay = false;
    await _playbackController.stop();
    _stateManager.clearState();
  }

  @override
  Future<void> seek(Duration position) => _playbackController.seek(position);

  @override
  Future<void> previous() => _playbackController.previous();

  @override
  Future<void> next() => _playbackController.next();

  // 上下文管理
  @override
  Future<void> playWithContext(PlaybackContext context) async {
    final request = ++_contextRequest;
    _shouldPlay = true;
    final applied = await _playbackController.setPlaybackContext(context);
    if (!applied || request != _contextRequest || !_shouldPlay) return;
    await _playbackController.play();
  }

  // 状态访问
  @override
  AudioTrackInfo? get currentTrack => _stateManager.currentTrack;

  @override
  PlaybackContext? get currentContext => _stateManager.currentContext;

  // 状态持久化
  @override
  Future<void> savePlaybackState() => _stateManager.saveState();

  @override
  Future<void> restorePlaybackState() async {
    try {
      AppLogger.debug('开始恢复播放状态');
      final state = await _stateManager.loadState();

      if (state == null) {
        AppLogger.debug('没有可恢复的播放状态');
        return;
      }

      AppLogger.debug('已加载保存的状态: workId=${state.work.id}');
      AppLogger.debug(
        '播放列表信息: 长度=${state.playlist.length}, 索引=${state.currentIndex}',
      );

      if (state.playlist.isEmpty) {
        AppLogger.debug('保存的播放列表为空，跳过恢复');
        return;
      }

      final context = PlaybackContext(
        work: state.work,
        files: state.files,
        currentFile: state.currentFile,
        playMode: state.playMode,
      );

      try {
        await _playbackController.setPlaybackContext(
          context,
          initialPosition: Duration(milliseconds: state.position),
        );
        AppLogger.debug('播放状态恢复成功');
      } catch (e) {
        AppLogger.error('设置播放上下文失败，跳过状态恢复', e);
      }
    } catch (e, stack) {
      AudioErrorHandler.handleError(AudioErrorType.init, '恢复播放状态', e, stack);
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    _shouldPlay = false;
    _contextRequest++;
    await _stateManager.saveState();
    await _playbackController.stop();
    await _stateManager.dispose();
    await _notificationService.dispose();
    await _player.dispose();
  }
}
