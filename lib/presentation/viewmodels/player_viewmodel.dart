import 'package:asmrapp/core/audio/events/playback_event.dart';
import 'package:asmrapp/core/audio/models/audio_track_info.dart';
import 'package:asmrapp/core/audio/models/playback_context.dart';
import 'package:asmrapp/core/subtitle/i_subtitle_service.dart';
import 'package:asmrapp/utils/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:asmrapp/core/audio/i_audio_player_service.dart';
import 'package:asmrapp/core/audio/models/subtitle.dart';
import 'dart:async';
import 'package:asmrapp/core/subtitle/subtitle_loader.dart';
import 'package:asmrapp/core/audio/events/playback_event_hub.dart';
import 'package:just_audio/just_audio.dart' show ProcessingState;

class PlayerViewModel extends ChangeNotifier {
  final IAudioPlayerService _audioService;
  final PlaybackEventHub _eventHub;
  final ISubtitleService _subtitleService;
  final _subtitleLoader = SubtitleLoader();

  bool _isPlaying = false;
  Duration? _position;
  Duration? _duration;
  Subtitle? _currentSubtitle;
  int _revision = -1;

  final List<StreamSubscription> _subscriptions = [];

  static const _tag = 'PlayerViewModel';

  PlayerViewModel({
    required IAudioPlayerService audioService,
    required PlaybackEventHub eventHub,
    required ISubtitleService subtitleService,
  }) : _audioService = audioService,
       _eventHub = eventHub,
       _subtitleService = subtitleService {
    _initStreams();
    _requestInitialState();
  }

  void _initStreams() {
    // 播放状态事件
    _subscriptions.add(
      _eventHub.playbackState.listen((event) {
        if (!_acceptRevision(event.revision)) return;
        _isPlaying =
            event.state.playing &&
            event.state.processingState != ProcessingState.completed;
        _position = event.position;
        _duration = event.duration;
        notifyListeners();
      }, onError: (error) => debugPrint('$_tag - 播放状态流错误: $error')),
    );

    // 音轨变更事件
    _subscriptions.add(
      _eventHub.trackChange.listen((event) {
        if (!_acceptRevision(event.revision)) return;
        notifyListeners();
      }, onError: (error) => debugPrint('$_tag - 音轨变更流错误: $error')),
    );

    // 播放进度事件
    _subscriptions.add(
      _eventHub.playbackProgress.listen((event) {
        if (!_acceptRevision(event.revision)) return;
        _position = event.position;
        _duration = event.duration;
        if (_position != null) {
          _subtitleService.updatePosition(_position!);
        }
        notifyListeners();
      }, onError: (error) => debugPrint('$_tag - 播放进度流错误: $error')),
    );

    // 上下文变更事件
    _subscriptions.add(
      _eventHub.contextChange.listen((event) async {
        if (!_acceptRevision(event.revision)) return;
        try {
          await _loadSubtitleIfAvailable(event.context);
        } catch (error) {
          debugPrint('$_tag - 字幕加载错误: $error');
        }
        if (event.revision != _revision) return;
        // 如果有保存的位置，在字幕加载完成后更新位置
        if (_position != null) {
          _subtitleService.updatePosition(_position!);
        }
      }, onError: (error) => debugPrint('$_tag - 上下文流错误: $error')),
    );

    // 使用新添加的 initialState 流
    _subscriptions.add(
      _eventHub.initialState.listen((event) {
        if (!_acceptRevision(event.revision)) return;
        _isPlaying =
            event.state.playing &&
            event.state.processingState != ProcessingState.completed;
        _position = event.position;
        _duration = event.duration;
        if (event.track != null) {
          notifyListeners();
        }
        if (event.context != null) {
          unawaited(
            _loadSubtitleIfAvailable(event.context!).catchError((error) {
              debugPrint('$_tag - 初始字幕加载错误: $error');
            }),
          );
        }
        notifyListeners();
      }, onError: (error) => debugPrint('$_tag - 初始状态流错误: $error')),
    );

    _initSubtitleStreams();
  }

  void _initSubtitleStreams() {
    _subscriptions.add(
      _subtitleService.subtitleStream.listen((subtitleList) {
        debugPrint('$_tag - 字幕列表更新: ${subtitleList != null ? '已加载' : '未加载'}');
      }, onError: (error) => debugPrint('$_tag - 字幕流错误: $error')),
    );

    _subscriptions.add(
      _subtitleService.currentSubtitleStream.listen((subtitle) {
        _currentSubtitle = subtitle;
        notifyListeners();
      }, onError: (error) => debugPrint('$_tag - 当前字幕流错误: $error')),
    );
  }

  bool get isPlaying => _isPlaying;
  Duration? get position => _position;
  Duration? get duration => _duration;
  Subtitle? get currentSubtitle => _currentSubtitle;

  Future<void> playPause() async {
    if (_isPlaying) {
      await _audioService.pause();
    } else {
      await _audioService.resume();
    }
  }

  Future<void> seek(Duration position) async {
    await _audioService.seek(position);
  }

  Future<void> previous() async {
    await _audioService.previous();
  }

  Future<void> next() async {
    await _audioService.next();
  }

  Future<void> stop() async {
    await _audioService.stop();
    _position = Duration.zero;
    notifyListeners();
  }

  @override
  void dispose() {
    for (var subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }

  // 请求初始状态
  void _requestInitialState() {
    _eventHub.emit(RequestInitialStateEvent());
  }

  bool _acceptRevision(int revision) {
    if (revision < _revision) return false;
    _revision = revision;
    return true;
  }

  // 修改字幕加载方法，返回 Future 以便等待加载完成
  Future<void> _loadSubtitleIfAvailable(PlaybackContext context) async {
    final subtitleFile = _subtitleLoader.findSubtitleFile(
      context.currentFile,
      context.files,
    );
    if (subtitleFile?.mediaDownloadUrl != null) {
      await _subtitleService.loadSubtitle(subtitleFile!.mediaDownloadUrl!);
    } else {
      _subtitleService.clearSubtitle();
      AppLogger.debug('未找到字幕文件，清除现有字幕');
    }
  }

  AudioTrackInfo? get currentTrackInfo => _audioService.currentTrack;
  PlaybackContext? get currentContext => _audioService.currentContext;

  Future<void> seekToNextLyric() async {
    final currentSubtitle = _subtitleService.currentSubtitleWithState;
    final subtitleList = _subtitleService.subtitleList;

    if (currentSubtitle != null && subtitleList != null) {
      final nextSubtitle = currentSubtitle.subtitle.getNext(subtitleList);
      if (nextSubtitle != null) {
        await seek(nextSubtitle.start);
      }
    }
  }

  Future<void> seekToPreviousLyric() async {
    final currentSubtitle = _subtitleService.currentSubtitleWithState;
    final subtitleList = _subtitleService.subtitleList;

    if (currentSubtitle != null && subtitleList != null) {
      final previousSubtitle = currentSubtitle.subtitle.getPrevious(
        subtitleList,
      );
      if (previousSubtitle != null) {
        await seek(previousSubtitle.start);
      }
    }
  }
}
