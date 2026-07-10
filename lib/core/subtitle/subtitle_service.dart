import 'dart:async';
import 'package:asmrapp/utils/logger.dart';
import 'package:asmrapp/core/audio/models/subtitle.dart';
import 'package:asmrapp/core/subtitle/i_subtitle_service.dart';
import 'package:get_it/get_it.dart';
import 'package:asmrapp/core/subtitle/subtitle_loader.dart';
import 'package:asmrapp/core/subtitle/managers/subtitle_state_manager.dart';

class SubtitleService implements ISubtitleService {
  final _subtitleLoader = GetIt.I<SubtitleLoader>();
  final _stateManager = SubtitleStateManager();
  int _loadGeneration = 0;

  @override
  Stream<SubtitleList?> get subtitleStream => _stateManager.subtitleStream;

  @override
  Stream<Subtitle?> get currentSubtitleStream =>
      _stateManager.currentSubtitleStream;

  @override
  Subtitle? get currentSubtitle => _stateManager.currentSubtitle;

  @override
  Future<void> loadSubtitle(String url) async {
    final generation = ++_loadGeneration;
    try {
      _stateManager.clear();
      final subtitleList = await _subtitleLoader.loadSubtitleContent(url);
      if (generation != _loadGeneration) return;
      _stateManager.setSubtitleList(subtitleList);
    } catch (e) {
      if (generation != _loadGeneration) return;
      AppLogger.debug('字幕加载失败: $e');
      _stateManager.clear();
      rethrow;
    }
  }

  @override
  void updatePosition(Duration position) {
    _stateManager.updatePosition(position);
  }

  @override
  void dispose() {
    _loadGeneration++;
    _stateManager.dispose();
  }

  @override
  SubtitleList? get subtitleList => _stateManager.subtitleList;

  @override
  void clearSubtitle() {
    _loadGeneration++;
    _stateManager.clear();
  }

  @override
  Stream<SubtitleWithState?> get currentSubtitleWithStateStream =>
      _stateManager.currentSubtitleWithStateStream;

  @override
  SubtitleWithState? get currentSubtitleWithState =>
      _stateManager.currentSubtitleWithState;
}
