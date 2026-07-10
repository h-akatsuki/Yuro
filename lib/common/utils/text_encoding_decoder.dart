import 'dart:convert';

import 'package:charset/charset.dart';

/// Decodes text files served by the API without assuming that every file is
/// UTF-8. Older Japanese text files are commonly encoded as Shift_JIS.
class TextEncodingDecoder {
  const TextEncodingDecoder._();

  static String decode(List<int> bytes, {String? contentType}) {
    if (bytes.isEmpty) return '';

    // Check BOMs before the HTTP header. A BOM is the strongest signal and
    // also gives us the byte order for UTF-16/UTF-32.
    if (_startsWith(bytes, const [0x00, 0x00, 0xfe, 0xff]) ||
        _startsWith(bytes, const [0xff, 0xfe, 0x00, 0x00])) {
      return _withoutBom(utf32.decode(bytes));
    }
    if (_startsWith(bytes, const [0xfe, 0xff]) ||
        _startsWith(bytes, const [0xff, 0xfe])) {
      return _withoutBom(utf16.decode(bytes));
    }
    if (_startsWith(bytes, const [0xef, 0xbb, 0xbf])) {
      return utf8.decode(bytes.sublist(3));
    }

    final declaredCharset = _charsetFromContentType(contentType);
    if (declaredCharset != null) {
      final declaredResult = _tryDecodeDeclared(bytes, declaredCharset);
      if (declaredResult != null) return _withoutBom(declaredResult);
    }

    // UTF-8 must be attempted strictly. Using allowMalformed here hides a
    // wrong encoding by replacing Japanese characters with U+FFFD.
    final utf8Result = _tryDecode(utf8, bytes);
    if (utf8Result != null) return _withoutBom(utf8Result);

    // The service primarily hosts Japanese works, so prefer the two common
    // Japanese legacy encodings before the broader GBK fallback.
    for (final encoding in <Encoding>[shiftJis, eucJp, gbk]) {
      final result = _tryDecode(encoding, bytes);
      if (result != null) return _withoutBom(result);
    }

    // Preserve every byte as a last resort instead of returning replacement
    // characters or failing the entire preview.
    return latin1.decode(bytes);
  }

  static String? _charsetFromContentType(String? contentType) {
    if (contentType == null || contentType.isEmpty) return null;
    final match = RegExp(
      r'''charset\s*=\s*["']?([^;\s"']+)''',
      caseSensitive: false,
    ).firstMatch(contentType);
    return match?.group(1)?.trim().toLowerCase();
  }

  static String? _tryDecodeDeclared(List<int> bytes, String charsetName) {
    final normalized = charsetName.replaceAll('_', '-');

    try {
      switch (normalized) {
        case 'utf-16le':
          return const Utf16Decoder().decodeUtf16Le(bytes);
        case 'utf-16be':
          return const Utf16Decoder().decodeUtf16Be(bytes);
        case 'utf-32le':
          return const Utf32Decoder().decodeUtf32Le(bytes);
        case 'utf-32be':
          return const Utf32Decoder().decodeUtf32Be(bytes);
        case 'cp932':
        case 'ms932':
        case 'windows-31j':
        case 'x-sjis':
        case 'sjis':
          return shiftJis.decode(bytes);
      }
    } on FormatException {
      return null;
    } on ArgumentError {
      return null;
    }

    return _tryDecode(Charset.getByName(normalized), bytes);
  }

  static String? _tryDecode(Encoding? encoding, List<int> bytes) {
    if (encoding == null) return null;
    try {
      return encoding.decode(bytes);
    } on FormatException {
      return null;
    } on ArgumentError {
      return null;
    }
  }

  static bool _startsWith(List<int> bytes, List<int> prefix) {
    if (bytes.length < prefix.length) return false;
    for (var index = 0; index < prefix.length; index++) {
      if (bytes[index] != prefix[index]) return false;
    }
    return true;
  }

  static String _withoutBom(String value) {
    if (value.startsWith('\ufeff')) return value.substring(1);
    return value;
  }
}
