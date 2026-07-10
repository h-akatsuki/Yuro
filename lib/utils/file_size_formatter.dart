class FileSizeFormatter {
  static String format(int? size) {
    if (size == null) return '';
    final bytes = size < 0 ? 0 : size;
    const units = <String>['B', 'KB', 'MB', 'GB', 'TB'];
    var value = bytes.toDouble();
    var unitIndex = 0;
    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }
    if (unitIndex == 0) return '$bytes B';
    final decimals = value >= 100 ? 0 : (value >= 10 ? 1 : 2);
    return '${value.toStringAsFixed(decimals)} ${units[unitIndex]}';
  }
}
