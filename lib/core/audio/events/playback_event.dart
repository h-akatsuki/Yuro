import 'package:just_audio/just_audio.dart';
import '../models/audio_track_info.dart';
import '../models/playback_context.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/data/models/works/work.dart';

/// 播放事件基类
abstract class PlaybackEvent {}

/// 播放状态事件
class PlaybackStateEvent extends PlaybackEvent {
  final PlayerState state;
  final Duration position;
  final Duration? duration;
  PlaybackStateEvent(this.state, this.position, this.duration);
}

/// 播放上下文事件
class PlaybackContextEvent extends PlaybackEvent {
  final PlaybackContext context;
  PlaybackContextEvent(this.context);
}

/// 音轨变更事件
class TrackChangeEvent extends PlaybackEvent {
  final AudioTrackInfo track;
  final Child file;
  final Work work;
  TrackChangeEvent(this.track, this.file, this.work);
}

/// 播放错误事件
class PlaybackErrorEvent extends PlaybackEvent {
  final String operation;
  final dynamic error;
  final StackTrace? stackTrace;
  PlaybackErrorEvent(this.operation, this.error, [this.stackTrace]);
}

/// 播放完成事件
class PlaybackCompletedEvent extends PlaybackEvent {
  final PlaybackContext context;
  PlaybackCompletedEvent(this.context);
}

/// 播放进度事件
class PlaybackProgressEvent extends PlaybackEvent {
  final Duration position;
  final Duration? bufferedPosition;
  PlaybackProgressEvent(this.position, this.bufferedPosition);
}

/// 添加初始状态相关事件
class RequestInitialStateEvent extends PlaybackEvent {}

class InitialStateEvent extends PlaybackEvent {
  final AudioTrackInfo? track;
  final PlaybackContext? context;
  InitialStateEvent(this.track, this.context);
}
