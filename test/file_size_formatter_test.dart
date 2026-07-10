import 'package:asmrapp/utils/file_size_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats byte sizes with compact adaptive precision', () {
    expect(FileSizeFormatter.format(null), '');
    expect(FileSizeFormatter.format(0), '0 B');
    expect(FileSizeFormatter.format(1024), '1.00 KB');
    expect(FileSizeFormatter.format(15 * 1024), '15.0 KB');
    expect(FileSizeFormatter.format(120 * 1024 * 1024), '120 MB');
    expect(FileSizeFormatter.format(2 * 1024 * 1024 * 1024), '2.00 GB');
  });
}
