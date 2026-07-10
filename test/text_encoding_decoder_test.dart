import 'package:asmrapp/common/utils/text_encoding_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextEncodingDecoder', () {
    test('decodes UTF-8 without a BOM', () {
      const bytes = <int>[
        0xe3,
        0x81,
        0x93,
        0xe3,
        0x82,
        0x93,
        0xe3,
        0x81,
        0xab,
        0xe3,
        0x81,
        0xa1,
        0xe3,
        0x81,
        0xaf,
      ];

      expect(TextEncodingDecoder.decode(bytes), 'こんにちは');
    });

    test('removes a UTF-8 BOM', () {
      const bytes = <int>[0xef, 0xbb, 0xbf, 0x74, 0x65, 0x78, 0x74];

      expect(TextEncodingDecoder.decode(bytes), 'text');
    });

    test('falls back to Shift_JIS for Japanese legacy text', () {
      const bytes = <int>[
        0x82,
        0xb1,
        0x82,
        0xf1,
        0x82,
        0xc9,
        0x82,
        0xbf,
        0x82,
        0xcd,
      ];

      expect(TextEncodingDecoder.decode(bytes), 'こんにちは');
    });

    test('honors a declared CP932-compatible charset', () {
      const bytes = <int>[0x93, 0xfa, 0x96, 0x7b, 0x8c, 0xea];

      expect(
        TextEncodingDecoder.decode(
          bytes,
          contentType: 'text/plain; charset=windows-31j',
        ),
        '日本語',
      );
    });

    test('decodes UTF-16 with a BOM', () {
      const bytes = <int>[0xff, 0xfe, 0xe5, 0x65, 0x2c, 0x67];

      expect(TextEncodingDecoder.decode(bytes), '日本');
    });
  });
}
