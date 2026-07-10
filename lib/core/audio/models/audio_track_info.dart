class AudioTrackInfo {
  final String title;
  final String artist;
  final String coverUrl;
  final String url;
  final Duration? duration;

  AudioTrackInfo({
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.url,
    this.duration,
  });

  AudioTrackInfo copyWithDuration(Duration? duration) {
    return AudioTrackInfo(
      title: title,
      artist: artist,
      coverUrl: coverUrl,
      url: url,
      duration: duration,
    );
  }
}
