import 'dart:async';

import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/playback/playback_state.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:just_audio/just_audio.dart';

import '../events/playback_event.dart' hide PlaybackEvent;
import '../events/playback_event_hub.dart';
import '../models/audio_track_info.dart';
import '../models/playback_context.dart';
import '../storage/i_playback_state_repository.dart';
import '../utils/audio_error_handler.dart';
import '../utils/track_info_creator.dart';

class PlaybackStateManager {
  final AudioPlayer _player;
  final PlaybackEventHub _eventHub;
  final IPlaybackStateRepository _stateRepository;

  AudioTrackInfo? _currentTrack;
  PlaybackContext? _currentContext;
  bool _isTransitioning = false;
  bool _listenersInitialized = false;
  bool _disposed = false;
  int _revision = 0;
  int? _completedRevision;
  int? _lastScheduledSaveSecond;
  PlayerState? _lastSavedPlayerState;
  Future<void> _saveQueue = Future<void>.value();

  final List<StreamSubscription> _subscriptions = [];

  PlaybackStateManager({
    required AudioPlayer player,
    required PlaybackEventHub eventHub,
    required IPlaybackStateRepository stateRepository,
  }) : _player = player,
       _eventHub = eventHub,
       _stateRepository = stateRepository;

  // 初始化状态监听
  void initStateListeners() {
    if (_listenersInitialized) return;
    _listenersInitialized = true;

    _setupEventListeners();

    // 监听播放器索引变化
    _subscriptions.add(_player.currentIndexStream.listen(_handleCurrentIndex));

    // playbackEvent 同时携带 index、position、duration 和 buffer，使用同一
    // 个原子快照可避免切歌边界混入上一首的时刻。
    _subscriptions.add(
      _player.playbackEventStream.listen(_handlePlaybackEvent),
    );

    // positionStream 仅用于平滑刷新 UI。曲目身份仍由 currentIndex 校验。
    _subscriptions.add(_player.positionStream.listen(_handlePosition));

    _subscriptions.add(
      _player.errorStream.listen((error) {
        _eventHub.emit(
          PlaybackErrorEvent('audio playback', error, StackTrace.current),
        );
      }),
    );
  }

  /// 新しい音源のロード中は、旧音源から遅れて届くイベントを遮断する。
  void beginContextTransition() {
    _revision++;
    _isTransitioning = true;
    _completedRevision = null;
    _lastScheduledSaveSecond = null;
    _emitResetSnapshot(ProcessingState.loading);
  }

  /// ロードが完了してから context と track を同時に公開する。
  void commitContextTransition(PlaybackContext context, {Duration? duration}) {
    _currentContext = context;
    _currentTrack = TrackInfoCreator.createFromFile(
      context.currentFile,
      context.work,
    ).copyWithDuration(duration);
    _isTransitioning = false;

    _emitContext();
    _emitTrack();
    _emitCurrentSnapshot();
    unawaited(saveState());
  }

  void abortContextTransition() {
    if (!_isTransitioning) return;
    _isTransitioning = false;
    _emitCurrentSnapshot();
  }

  void _emitContext() {
    final context = _currentContext;
    if (context != null) {
      _eventHub.emit(PlaybackContextEvent(context, revision: _revision));
    }
  }

  void _emitTrack() {
    final context = _currentContext;
    final track = _currentTrack;
    if (context == null || track == null) return;

    _eventHub.emit(
      TrackChangeEvent(
        track,
        context.currentFile,
        context.work,
        revision: _revision,
      ),
    );
  }

  void updateTrackAndContext(Child file, Work work) {
    final context = _currentContext;
    if (context == null || context.currentFile == file) return;

    _revision++;
    _completedRevision = null;
    _lastScheduledSaveSecond = null;
    _currentContext = context.copyWithFile(file);
    _currentTrack = TrackInfoCreator.createFromFile(file, work);

    _emitResetSnapshot(ProcessingState.loading);
    _emitContext();
    _emitTrack();
  }

  void _onPlaybackCompleted() {
    if (_currentContext == null) return;
    // just_audio は completed でも playing=true を維持するため、明示的に
    // pause して UI/通知の再生ボタンを正しい状態へ戻す。
    unawaited(_player.pause());
    _eventHub.emit(PlaybackCompletedEvent(_currentContext!));
  }

  // 状态访问
  AudioTrackInfo? get currentTrack => _currentTrack;
  PlaybackContext? get currentContext => _currentContext;

  void clearState() {
    _revision++;
    _isTransitioning = false;
    _currentTrack = null;
    _currentContext = null;
    _completedRevision = null;
    _lastScheduledSaveSecond = null;
    _emitResetSnapshot(ProcessingState.idle);
  }

  // 状态持久化
  Future<void> saveState() async {
    final context = _currentContext;
    if (context == null || _isTransitioning || _disposed) return;

    final state = PlaybackState(
      work: context.work,
      files: context.files,
      currentFile: context.currentFile,
      playlist: context.playlist,
      currentIndex: context.currentIndex,
      playMode: context.playMode,
      position: _player.position.inMilliseconds,
      timestamp: DateTime.now().toIso8601String(),
    );

    _saveQueue = _saveQueue.then((_) async {
      try {
        await _stateRepository.saveState(state);
      } catch (e, stack) {
        AudioErrorHandler.handleError(AudioErrorType.state, '保存播放状态', e, stack);
      }
    });
    await _saveQueue;
  }

  Future<PlaybackState?> loadState() async {
    try {
      return await _stateRepository.loadState();
    } catch (e, stack) {
      AudioErrorHandler.handleError(AudioErrorType.state, '加载播放状态', e, stack);
      return null;
    }
  }

  void _setupEventListeners() {
    // 处理初始状态请求
    _subscriptions.add(
      _eventHub.requestInitialState.listen((_) {
        _eventHub.emit(
          InitialStateEvent(
            track: _currentTrack,
            context: _currentContext,
            state: _isTransitioning
                ? PlayerState(false, ProcessingState.loading)
                : _player.playerState,
            position: _isTransitioning ? Duration.zero : _player.position,
            bufferedPosition: _isTransitioning
                ? Duration.zero
                : _player.bufferedPosition,
            duration: _isTransitioning ? null : _player.duration,
            revision: _revision,
          ),
        );
      }),
    );
  }

  void _handleCurrentIndex(int? index) {
    final context = _currentContext;
    if (_isTransitioning || context == null || index == null) return;
    if (index < 0 || index >= context.playlist.length) return;

    updateTrackAndContext(context.playlist[index], context.work);
  }

  void _handlePlaybackEvent(PlaybackEvent event) {
    if (_isTransitioning || !_isCurrentTrackEvent(event.currentIndex)) return;

    final state = _player.playerState;
    _eventHub.emit(
      PlaybackStateEvent(
        state,
        _player.position,
        event.duration,
        revision: _revision,
      ),
    );
    _emitProgress(
      position: _player.position,
      bufferedPosition: event.bufferedPosition,
      duration: event.duration,
    );
    _updateTrackDuration(event.duration);

    if (state.processingState == ProcessingState.completed &&
        _completedRevision != _revision) {
      _completedRevision = _revision;
      _onPlaybackCompleted();
    }

    final previousState = _lastSavedPlayerState;
    if (previousState == null ||
        previousState.playing != state.playing ||
        previousState.processingState != state.processingState) {
      _lastSavedPlayerState = state;
      unawaited(saveState());
    }
  }

  void _handlePosition(Duration position) {
    if (_isTransitioning || !_isCurrentTrackEvent(_player.currentIndex)) return;

    _emitProgress(
      position: position,
      bufferedPosition: _player.bufferedPosition,
      duration: _player.duration,
    );

    final second = position.inSeconds;
    final lastSecond = _lastScheduledSaveSecond;
    if (lastSecond == null || (second - lastSecond).abs() >= 5) {
      _lastScheduledSaveSecond = second;
      unawaited(saveState());
    }
  }

  bool _isCurrentTrackEvent(int? index) {
    final context = _currentContext;
    return context != null && index == context.currentIndex;
  }

  void _emitCurrentSnapshot() {
    final state = _player.playerState;
    _eventHub.emit(
      PlaybackStateEvent(
        state,
        _player.position,
        _player.duration,
        revision: _revision,
      ),
    );
    _emitProgress(
      position: _player.position,
      bufferedPosition: _player.bufferedPosition,
      duration: _player.duration,
    );
    _updateTrackDuration(_player.duration);
  }

  void _emitResetSnapshot(ProcessingState processingState) {
    _eventHub.emit(
      PlaybackStateEvent(
        PlayerState(false, processingState),
        Duration.zero,
        null,
        revision: _revision,
      ),
    );
    _emitProgress(
      position: Duration.zero,
      bufferedPosition: Duration.zero,
      duration: null,
    );
  }

  void _emitProgress({
    required Duration position,
    required Duration bufferedPosition,
    required Duration? duration,
  }) {
    _eventHub.emit(
      PlaybackProgressEvent(
        position,
        bufferedPosition,
        duration,
        revision: _revision,
      ),
    );
  }

  void _updateTrackDuration(Duration? duration) {
    final track = _currentTrack;
    if (track == null || duration == null || track.duration == duration) return;
    _currentTrack = track.copyWithDuration(duration);
    _emitTrack();
  }

  Future<void> dispose() async {
    _disposed = true;
    for (var subscription in _subscriptions) {
      await subscription.cancel();
    }
    _subscriptions.clear();
    await _saveQueue;
  }
}
