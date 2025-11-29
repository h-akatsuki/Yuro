import 'package:asmrapp/data/models/files/child.dart';

class SubtitleMatcher {
  // 支持的字幕格式
  static const supportedFormats = ['.vtt', '.lrc'];

  // 检查文件是否为字幕文件
  static bool isSubtitleFile(String? fileName) {
    if (fileName == null) return false;
    return supportedFormats
        .any((format) => fileName.toLowerCase().endsWith(format));
  }

  // 获取音频文件的可能的字幕文件名列表
  static List<String> getPossibleSubtitleNames(String audioFileName) {
    final names = <String>[];
    final baseName = _getBaseName(audioFileName);

    // 生成可能的字幕文件名
    for (final format in supportedFormats) {
      // 1. 直接替换扩展名: aaa.mp3 -> aaa.vtt
      names.add('$baseName$format');

      // 2. 保留原扩展名: aaa.mp3 -> aaa.mp3.vtt
      names.add('$audioFileName$format');
    }

    return names;
  }

  // 查找匹配的字幕文件
  static Child? findMatchingSubtitle(
      String audioFileName, List<Child> siblings) {
    final possibleNames = getPossibleSubtitleNames(audioFileName);

    // 遍历所有可能的字幕文件名
    for (final subtitleName in possibleNames) {
      try {
        final subtitleFile = siblings.firstWhere(
            (file) => file.title?.toLowerCase() == subtitleName.toLowerCase());
        return subtitleFile;
      } catch (_) {
        // 继续查找下一个可能的文件名
        continue;
      }
    }

    return null;
  }

  // 获取不带扩展名的文件名
  static String _getBaseName(String fileName) {
    final lastDot = fileName.lastIndexOf('.');
    if (lastDot == -1) return fileName;
    return fileName.substring(0, lastDot);
  }
}
