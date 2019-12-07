import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'app_localizations.dart';

class LocalizationsDelegates {
  static LocalizationsDelegates _instance;
  List<LocalizationsDelegate> _localizationsDelegates;
  List<Locale> _supportedLocales;
  Map<String, String> _supportedLanguages;

  LocalizationsDelegates._() {
    _supportedLanguages = {'en': 'EN', 'vi': 'VN'};
    _supportedLocales = [];
    _supportedLanguages.forEach((languageCode, countryCode) {
      _supportedLocales.add(Locale(languageCode, countryCode));
    });
    _localizationsDelegates = [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      RefreshLocalizations.delegate
    ];
  }

  Locale localeResolutionCallback(
      Locale locale, Iterable<Locale> supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  bool isSupported(Locale locale) {
    return _supportedLanguages.keys.contains(locale.languageCode);
  }

  static LocalizationsDelegates get instance {
    if (_instance == null) {
      _instance = LocalizationsDelegates._();
    }
    return _instance;
  }

  List<LocalizationsDelegate> get localizationsDelegates =>
      _localizationsDelegates;

  List<Locale> get supportedLocales => _supportedLocales;

  Map<String, String> get supportedLanguages => _supportedLanguages;
}
