import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeMode, ThemeMode> {
  static const String DARK_THEME = "ThemeBloc_DARK_THEME";
  SharedPreferences? prefs;

  ThemeBloc() : super(ThemeMode.light) {
    _loadSettings();
    on<ThemeMode>((event, emit) {
      emit(event);
      _saveSettings(event);
    });
  }

  _loadSettings() async {
    prefs = await SharedPreferences.getInstance();
    bool _darkTheme = prefs?.getBool(DARK_THEME) ?? false;
    add(_darkTheme ? ThemeMode.dark : ThemeMode.light);
    return _darkTheme;
  }

  _saveSettings(ThemeMode themeType) async {
    bool darkTheme = themeType == ThemeMode.dark;
    await prefs?.setBool(DARK_THEME, darkTheme);
  }
}
