import 'dart:async';

import 'package:asmrapp/core/audio/events/playback_event.dart';
import 'package:asmrapp/core/audio/events/playback_event_hub.dart';
import 'package:asmrapp/core/audio/i_audio_player_service.dart';
import 'package:asmrapp/core/audio/models/audio_track_info.dart';
import 'package:asmrapp/core/audio/models/playback_context.dart';
import 'package:asmrapp/core/audio/models/subtitle.dart';
import 'package:asmrapp/core/subtitle/i_subtitle_service.dart';
import 'package:asmrapp/presentation/viewmodels/player_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  late PlaybackEventHub eventHub;
  late _FakeAudioPlayerService audioService;
  late _FakeSubtitleService subtitleService;
  late PlayerViewModel viewModel;

  setUp(() {
    eventHub = PlaybackEventHub();
    audioService = _FakeAudioPlayerService();
    subtitleService = _FakeSubtitleService();
    viewModel = PlayerViewModel(
      audioService: audioService,
      eventHub: eventHub,
      subtitleService: subtitleService,
    );
  });

  tearDown(() async {
    viewModel.dispose();
    subtitleService.dispose();
    eventHub.dispose();
  });

  test('同じ position でも後から判明した duration を反映する', () async {
    eventHub.emit(
      PlaybackProgressEvent(
        const Duration(seconds: 12),
        const Duration(seconds: 20),
        const Duration(seconds: 60),
        revision: 1,
      ),
    );
    await _flushStreams();

    eventHub.emit(
      PlaybackProgressEvent(
        const Duration(seconds: 12),
        const Duration(seconds: 20),
        const Duration(seconds: 90),
        revision: 1,
      ),
    );
    await _flushStreams();

    expect(viewModel.position, const Duration(seconds: 12));
    expect(viewModel.duration, const Duration(seconds: 90));
  });

  test('新しい曲へ切り替えた後は旧 revision の時刻を無視する', () async {
    eventHub.emit(
      PlaybackProgressEvent(Duration.zero, Duration.zero, null, revision: 2),
    );
    await _flushStreams();

    eventHub.emit(
      PlaybackProgressEvent(
        const Duration(seconds: 48),
        const Duration(seconds: 50),
        const Duration(minutes: 2),
        revision: 1,
      ),
    );
    await _flushStreams();

    expect(viewModel.position, Duration.zero);
    expect(viewModel.duration, isNull);
  });

  test('再生・一時停止コマンドの完了を待つ', () async {
    eventHub.emit(
      PlaybackStateEvent(
        PlayerState(false, ProcessingState.ready),
        Duration.zero,
        const Duration(minutes: 1),
        revision: 1,
      ),
    );
    await _flushStreams();
    await viewModel.playPause();

    expect(audioService.resumeCalls, 1);

    eventHub.emit(
      PlaybackStateEvent(
        PlayerState(true, ProcessingState.ready),
        const Duration(seconds: 1),
        const Duration(minutes: 1),
        revision: 1,
      ),
    );
    await _flushStreams();
    await viewModel.playPause();

    expect(audioService.pauseCalls, 1);
  });
}

Future<void> _flushStreams() => Future<void>.delayed(Duration.zero);

class _FakeAudioPlayerService implements IAudioPlayerService {
  int pauseCalls = 0;
  int resumeCalls = 0;

  @override
  AudioTrackInfo? get currentTrack => null;

  @override
  PlaybackContext? get currentContext => null;

  @override
  Future<void> pause() async => pauseCalls++;

  @override
  Future<void> resume() async => resumeCalls++;

  @override
  Future<void> next() async {}

  @override
  Future<void> previous() async {}

  @override
  Future<void> seek(Duration position) async {}

  @override
  Future<void> stop() async {}

  @override
  Future<void> playWithContext(PlaybackContext context) async {}

  @override
  Future<void> restorePlaybackState() async {}

  @override
  Future<void> savePlaybackState() async {}

  @override
  Future<void> dispose() async {}
}

class _FakeSubtitleService implements ISubtitleService {
  final _subtitleController = StreamController<SubtitleList?>.broadcast();
  final _currentController = StreamController<Subtitle?>.broadcast();
  final _currentWithStateController =
      StreamController<SubtitleWithState?>.broadcast();

  @override
  Subtitle? get currentSubtitle => null;

  @override
  SubtitleWithState? get currentSubtitleWithState => null;

  @override
  Stream<SubtitleWithState?> get currentSubtitleWithStateStream =>
      _currentWithStateController.stream;

  @override
  Stream<Subtitle?> get currentSubtitleStream => _currentController.stream;

  @override
  SubtitleList? get subtitleList => null;

  @override
  Stream<SubtitleList?> get subtitleStream => _subtitleController.stream;

  @override
  void clearSubtitle() {}

  @override
  Future<void> loadSubtitle(String url) async {}

  @override
  void updatePosition(Duration position) {}

  @override
  void dispose() {
    _subtitleController.close();
    _currentController.close();
    _currentWithStateController.close();
  }
}
