import 'package:asmrapp/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends ChangeNotifier {
  static const String _localeKey = 'app_locale_code';

  final SharedPreferences _prefs;

  LocaleController(this._prefs) {
    final savedLanguageCode = _prefs.getString(_localeKey);
    if (savedLanguageCode == null || savedLanguageCode.trim().isEmpty) {
      return;
    }

    final isSupported = AppLocalizations.supportedLocales.any(
      (locale) => locale.languageCode == savedLanguageCode,
    );
    if (isSupported) {
      _locale = Locale(savedLanguageCode);
    }
  }

  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> setLocale(Locale? locale) async {
    final currentLanguageCode = _locale?.languageCode;
    final nextLanguageCode = locale?.languageCode;
    if (currentLanguageCode == nextLanguageCode) {
      return;
    }

    _locale = locale;
    notifyListeners();

    if (locale == null) {
      await _prefs.remove(_localeKey);
      return;
    }

    await _prefs.setString(_localeKey, locale.languageCode);
  }
}
