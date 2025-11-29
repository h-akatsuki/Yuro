import 'package:just_audio/just_audio.dart';
import 'package:asmrapp/data/models/files/child.dart';
import 'package:asmrapp/core/audio/cache/audio_cache_manager.dart';

class PlaylistBuilder {
  static Future<List<AudioSource>> buildAudioSources(List<Child> files) async {
    return await Future.wait(files.map((file) async {
      return AudioCacheManager.createAudioSource(file.mediaDownloadUrl!);
    }));
  }

  static Future<void> updatePlaylist(
    ConcatenatingAudioSource playlist,
    List<AudioSource> sources,
  ) async {
    await playlist.clear();
    await playlist.addAll(sources);
  }

  static Future<void> setPlaylistSource({
    required AudioPlayer player,
    required ConcatenatingAudioSource playlist,
    required List<Child> files,
    required int initialIndex,
    required Duration initialPosition,
  }) async {
    final sources = await buildAudioSources(files);
    await updatePlaylist(playlist, sources);

    await player.setAudioSource(
      playlist,
      initialIndex: initialIndex,
      initialPosition: initialPosition,
    );
  }
}
