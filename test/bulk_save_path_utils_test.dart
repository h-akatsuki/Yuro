import 'package:asmrapp/core/download/bulk_save_path_utils.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the asmr.one work URL segment as the matching code', () {
    final work = Work(id: 42, sourceId: 'https://asmr.one/work/RJ01234567');

    expect(BulkSavePathUtils.workCode(work), 'RJ01234567');
  });

  test('builds a portable code-title directory name', () {
    expect(
      BulkSavePathUtils.workFolderName(
        code: 'RJ123',
        title: 'title: with / invalid * characters',
      ),
      'RJ123-title_ with _ invalid _ characters',
    );
  });

  test('matches complete, partial, and backup folders by code', () {
    expect(
      BulkSavePathUtils.directoryNameMatchesCode('RJ123-Some title', 'rj123'),
      isTrue,
    );
    expect(
      BulkSavePathUtils.directoryNameMatchesCode(
        '.RJ123-Some title.yuro-partial',
        'RJ123',
      ),
      isTrue,
    );
    expect(
      BulkSavePathUtils.directoryNameMatchesCode('RJ1234-Other', 'RJ123'),
      isFalse,
    );
  });
}
