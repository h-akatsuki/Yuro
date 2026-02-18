import 'package:asmrapp/data/models/files/child.dart';

class FilePreviewUtils {
  static const Set<String> _audioExtensions = {
    '.mp3',
    '.wav',
    '.flac',
    '.m4a',
    '.aac',
    '.ogg',
    '.opus',
  };

  static const Set<String> _imageExtensions = {
    '.jpg',
    '.jpeg',
    '.png',
    '.webp',
    '.gif',
    '.bmp',
  };

  static const Set<String> _textExtensions = {
    '.txt',
    '.md',
    '.json',
    '.xml',
    '.csv',
    '.log',
    '.yaml',
    '.yml',
    '.lrc',
    '.vtt',
    '.srt',
    '.ass',
    '.ssa',
  };

  static bool isAudio(Child file) {
    if (file.type?.toLowerCase() == 'audio') return true;
    return _audioExtensions.contains(_extension(file.title));
  }

  static bool isImage(Child file) {
    if (file.type?.toLowerCase() == 'image') return true;
    return _imageExtensions.contains(_extension(file.title));
  }

  static bool isText(Child file) {
    final type = file.type?.toLowerCase();
    if (type == 'text' || type == 'subtitle' || type == 'lyrics') return true;
    return _textExtensions.contains(_extension(file.title));
  }

  static bool canPreview(Child file) {
    return isImage(file) || isText(file);
  }

  static String? _extension(String? fileName) {
    if (fileName == null || fileName.isEmpty) return null;

    final dotIndex = fileName.lastIndexOf('.');
    if (dotIndex < 0 || dotIndex == fileName.length - 1) return null;

    return fileName.substring(dotIndex).toLowerCase();
  }
}
