import 'dart:ui' as ui;
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './bloc.dart';

class LocalizationsBloc extends Bloc<LocalizationsEvent, LocalizationsState> {
  static const String LOCALE = "LocalizationsBloc_LOCALE";

  SharedPreferences? prefs;

  LocalizationsBloc() : super(LocalizationsState(locale: ui.window.locale)) {
    _loadSettings();
    on<LocaleChanged>((event, emit) async {
      await _saveSettings(event.locale);
      emit(LocalizationsState(locale: event.locale));
    });
  }

  _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? localeString = prefs?.getStringList(LOCALE);
    if (localeString != null) {
      ui.Locale locale = ui.Locale(localeString.elementAt(0));
      add(LocaleChanged(locale: locale));
    }
  }

  _saveSettings(Locale locale) async {
    await prefs?.setStringList(LOCALE, [locale.languageCode]);
  }
}
