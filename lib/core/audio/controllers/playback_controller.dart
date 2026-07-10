import 'dart:async';

import 'package:asmrapp/utils/logger.dart';
import 'package:just_audio/just_audio.dart';
import '../models/playback_context.dart';
import '../models/play_mode.dart';
import '../state/playback_state_manager.dart';
import '../utils/playlist_builder.dart';
import '../utils/audio_error_handler.dart';

class PlaybackController {
  final AudioPlayer _player;
  final PlaybackStateManager _stateManager;
  int _contextGeneration = 0;
  bool _isSwitchingContext = false;
  String? _activeContextKey;
  Future<bool>? _activeContextFuture;

  PlaybackController({
    required AudioPlayer player,
    required PlaybackStateManager stateManager,
  }) : _player = player,
       _stateManager = stateManager;

  // 基础播放控制
  bool get isSwitchingContext => _isSwitchingContext;

  Future<void> play() async {
    if (_isSwitchingContext || _stateManager.currentContext == null) return;

    if (_player.processingState == ProcessingState.completed) {
      await _player.seek(Duration.zero, index: _player.currentIndex);
    }

    // just_audio の play() は一時停止/完了まで Future が完了しない。
    // コマンド自体は即座に返し、再生中エラーは errorStream とここで回収する。
    unawaited(
      _player.play().catchError((Object error, StackTrace stackTrace) {
        AppLogger.error('播放命令失败', error, stackTrace);
      }),
    );
  }

  Future<void> pause() => _player.pause();

  Future<void> stop() async {
    cancelPendingContext();
    await _player.stop();
  }

  Future<void> seek(Duration position, {int? index}) async {
    if (_isSwitchingContext || _stateManager.currentContext == null) return;

    final duration = _player.duration;
    final target = position < Duration.zero
        ? Duration.zero
        : duration != null && position > duration
        ? duration
        : position;
    await _player.seek(target, index: index);
  }

  // 播放列表控制
  Future<void> next() async {
    try {
      AppLogger.debug('尝试切换下一曲');
      if (_stateManager.currentContext == null) {
        AppLogger.debug('当前上下文为空，无法切换下一曲');
        return;
      }

      if (_isSwitchingContext) return;

      if (_player.hasNext) {
        AppLogger.debug('执行切换到下一曲');
        await _player.seekToNext();
      } else {
        AppLogger.debug('没有下一曲可切换');
      }
    } catch (e, stack) {
      AppLogger.error('切换下一曲失败', e, stack);
      AudioErrorHandler.handleError(AudioErrorType.playback, '切换下一曲', e, stack);
    }
  }

  Future<void> previous() async {
    try {
      AppLogger.debug('尝试切换上一曲');
      if (_stateManager.currentContext == null) {
        AppLogger.debug('当前上下文为空，无法切换上一曲');
        return;
      }

      if (_isSwitchingContext) return;

      if (_player.hasPrevious) {
        AppLogger.debug('执行切换到上一曲');
        await _player.seekToPrevious();
      } else {
        AppLogger.debug('没有上一曲可切换');
      }
    } catch (e, stack) {
      AppLogger.error('切换上一曲失败', e, stack);
      AudioErrorHandler.handleError(AudioErrorType.playback, '切换上一曲', e, stack);
    }
  }

  // 播放上下文设置
  Future<bool> setPlaybackContext(
    PlaybackContext context, {
    Duration? initialPosition,
  }) {
    final key = [
      context.work.id,
      context.currentFile.mediaDownloadUrl,
      context.playMode.name,
      initialPosition?.inMilliseconds ?? 0,
    ].join('|');
    if (_isSwitchingContext &&
        key == _activeContextKey &&
        _activeContextFuture != null) {
      return _activeContextFuture!;
    }

    final future = _setPlaybackContext(
      context,
      initialPosition: initialPosition,
    );
    _activeContextKey = key;
    _activeContextFuture = future;
    return future;
  }

  Future<bool> _setPlaybackContext(
    PlaybackContext context, {
    Duration? initialPosition,
  }) async {
    final generation = ++_contextGeneration;
    _isSwitchingContext = true;
    _stateManager.beginContextTransition();

    try {
      AppLogger.debug(
        '准备设置播放上下文: workId=${context.work.id}, file=${context.currentFile.title}',
      );
      AppLogger.debug(
        '播放列表状态: 长度=${context.playlist.length}, 当前索引=${context.currentIndex}',
      );

      // 验证上下文
      try {
        context.validate();
      } catch (e) {
        AppLogger.error('播放上下文验证失败', e);
        rethrow;
      }

      // setAudioSources 自身が旧ロードを安全に中断する。stop() を挟むと
      // idle/旧 position が余分に流れるため、再生意図だけを止める。
      await _player.pause();
      if (generation != _contextGeneration) return false;

      // ロード成功までは context を公開しない。
      AppLogger.debug('设置播放源: 初始位置=${initialPosition?.inMilliseconds}ms');
      final loadedDuration = await PlaylistBuilder.setPlaylistSource(
        player: _player,
        files: context.playlist,
        initialIndex: context.currentIndex,
        initialPosition: initialPosition ?? Duration.zero,
      );
      if (generation != _contextGeneration) return false;

      await _applyPlayMode(context.playMode);
      if (generation != _contextGeneration) return false;

      // 保存位置が曲末以上なら、完了状態を復元せず先頭から再開可能にする。
      if (initialPosition != null &&
          loadedDuration != null &&
          initialPosition >= loadedDuration) {
        await _player.seek(Duration.zero, index: context.currentIndex);
        if (generation != _contextGeneration) return false;
      }

      _stateManager.commitContextTransition(
        context,
        duration: _player.duration ?? loadedDuration,
      );

      AppLogger.debug('播放上下文设置完成');
      return true;
    } on PlayerInterruptedException catch (e, stack) {
      if (generation != _contextGeneration) {
        AppLogger.debug('旧的播放源加载已被新的请求取消');
        return false;
      }
      _stateManager.abortContextTransition();
      AppLogger.error('设置播放源被中断', e, stack);
      rethrow;
    } catch (e, stack) {
      if (generation == _contextGeneration) {
        _stateManager.abortContextTransition();
      }
      AppLogger.error('设置播放上下文失败', e, stack);
      AudioErrorHandler.handleError(
        AudioErrorType.context,
        '设置播放上下文',
        e,
        stack,
      );
      rethrow;
    } finally {
      if (generation == _contextGeneration) {
        _isSwitchingContext = false;
        _activeContextKey = null;
        _activeContextFuture = null;
      }
    }
  }

  void cancelPendingContext() {
    _contextGeneration++;
    _isSwitchingContext = false;
    _activeContextKey = null;
    _activeContextFuture = null;
  }

  Future<void> _applyPlayMode(PlayMode playMode) {
    return _player.setLoopMode(switch (playMode) {
      PlayMode.single => LoopMode.one,
      PlayMode.loop => LoopMode.all,
      PlayMode.sequence => LoopMode.off,
    });
  }
}
