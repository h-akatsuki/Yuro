import 'package:asmrapp/data/models/works/tag.dart';
import 'package:asmrapp/data/models/works/work.dart';
import 'package:flutter/widgets.dart';

enum _PreferredLanguage {
  chinese,
  japanese,
  english,
  other,
}

_PreferredLanguage _resolvePreferredLanguage(Locale locale) {
  switch (locale.languageCode.toLowerCase()) {
    case 'zh':
      return _PreferredLanguage.chinese;
    case 'ja':
      return _PreferredLanguage.japanese;
    case 'en':
      return _PreferredLanguage.english;
    default:
      return _PreferredLanguage.other;
  }
}

String _firstNonEmpty(Iterable<String?> values) {
  for (final value in values) {
    final normalized = value?.trim();
    if (normalized != null && normalized.isNotEmpty) {
      return normalized;
    }
  }
  return '';
}

List<String> _preferredEditionLangCodes(Locale locale) {
  switch (_resolvePreferredLanguage(locale)) {
    case _PreferredLanguage.chinese:
      return const ['CHI_HANS', 'CHI_HANT'];
    case _PreferredLanguage.japanese:
      return const ['JPN'];
    case _PreferredLanguage.english:
      return const ['ENG'];
    case _PreferredLanguage.other:
      return const [];
  }
}

extension TagLocalizationX on Tag {
  String localizedName(Locale locale) {
    switch (_resolvePreferredLanguage(locale)) {
      case _PreferredLanguage.chinese:
        return _firstNonEmpty([
          i18n?.zhCn?.name,
          i18n?.jaJp?.name,
          i18n?.enUs?.name,
          name,
        ]);
      case _PreferredLanguage.japanese:
        return _firstNonEmpty([
          i18n?.jaJp?.name,
          i18n?.zhCn?.name,
          i18n?.enUs?.name,
          name,
        ]);
      case _PreferredLanguage.english:
        return _firstNonEmpty([
          i18n?.enUs?.name,
          i18n?.jaJp?.name,
          i18n?.zhCn?.name,
          name,
        ]);
      case _PreferredLanguage.other:
        return _firstNonEmpty([
          i18n?.enUs?.name,
          i18n?.jaJp?.name,
          i18n?.zhCn?.name,
          name,
        ]);
    }
  }
}

extension WorkLocalizationX on Work {
  String localizedTitle(Locale locale) {
    final preferredTitles = <String?>[];
    final preferredLangCodes = _preferredEditionLangCodes(locale);
    final editions = otherLanguageEditionsInDb ?? const [];

    for (final langCode in preferredLangCodes) {
      for (final edition in editions) {
        if (edition.lang == langCode) {
          preferredTitles.add(edition.title);
        }
      }
    }

    return _firstNonEmpty([
      ...preferredTitles,
      title,
      sourceId,
    ]);
  }

  String localizedCircleName() {
    return _firstNonEmpty([
      circle?.name,
      name,
    ]);
  }
}
