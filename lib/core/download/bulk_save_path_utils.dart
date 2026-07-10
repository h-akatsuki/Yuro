import 'package:asmrapp/data/models/works/work.dart';

class BulkSavePathUtils {
  const BulkSavePathUtils._();

  static String workCode(Work work) {
    final sourceId = work.sourceId?.trim();
    if (sourceId != null && sourceId.isNotEmpty) {
      final uri = Uri.tryParse(sourceId);
      if (uri != null && uri.hasScheme && uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.last.trim();
      }
      return sourceId;
    }
    return 'work_${work.id ?? 'unknown'}';
  }

  static String normalizeCode(String code) => code.trim().toLowerCase();

  static String workFolderName({required String code, required String title}) {
    final safeCode = sanitizePathSegment(code, fallback: 'work');
    final safeTitle = sanitizePathSegment(title, fallback: safeCode);
    return '$safeCode-$safeTitle';
  }

  static bool directoryNameMatchesCode(String directoryName, String code) {
    var normalizedName = directoryName.trim().toLowerCase();
    if (normalizedName.startsWith('.')) {
      normalizedName = normalizedName.substring(1);
    }
    for (final suffix in const <String>['.yuro-partial', '.yuro-backup']) {
      if (normalizedName.endsWith(suffix)) {
        normalizedName = normalizedName.substring(
          0,
          normalizedName.length - suffix.length,
        );
      }
    }

    final normalizedCode = normalizeCode(code);
    return normalizedName == normalizedCode ||
        normalizedName.startsWith('$normalizedCode-');
  }

  static String sanitizePathSegment(
    String? original, {
    required String fallback,
  }) {
    final normalized = (original ?? '').trim();
    if (normalized.isEmpty) return fallback;

    var sanitized = normalized
        .replaceAll(RegExp(r'[\x00-\x1F\\/:*?"<>|]'), '_')
        .replaceFirst(RegExp(r'[. ]+$'), '');
    if (sanitized.isEmpty || sanitized == '.' || sanitized == '..') {
      return fallback;
    }

    final baseName = sanitized.split('.').first.toUpperCase();
    const reservedWindowsNames = <String>{
      'CON',
      'PRN',
      'AUX',
      'NUL',
      'COM1',
      'COM2',
      'COM3',
      'COM4',
      'COM5',
      'COM6',
      'COM7',
      'COM8',
      'COM9',
      'LPT1',
      'LPT2',
      'LPT3',
      'LPT4',
      'LPT5',
      'LPT6',
      'LPT7',
      'LPT8',
      'LPT9',
    };
    if (reservedWindowsNames.contains(baseName)) {
      sanitized = '_$sanitized';
    }

    if (sanitized.length > 160) {
      final dotIndex = sanitized.lastIndexOf('.');
      final extension = dotIndex > 0 && sanitized.length - dotIndex <= 16
          ? sanitized.substring(dotIndex)
          : '';
      sanitized = '${sanitized.substring(0, 160 - extension.length)}$extension';
    }
    return sanitized;
  }
}
