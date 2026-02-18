import 'package:just_audio/just_audio.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/core/audio/cache/audio_cache_manager.dart';

class PlaylistBuilder {
  static Future<List<AudioSource>> buildAudioSources(List<Child> files) async {
    return await Future.wait(files.map((file) async {
      return AudioCacheManager.createAudioSource(file.mediaDownloadUrl!);
    }));
  }

  static Future<void> setPlaylistSource({
    required AudioPlayer player,
    required List<Child> files,
    required int initialIndex,
    required Duration initialPosition,
  }) async {
    final sources = await buildAudioSources(files);
    await player.setAudioSources(
      sources,
      initialIndex: initialIndex,
      initialPosition: initialPosition,
    );
  }
}
