import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todo/ui/global/theme/theme_data/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String DARK_THEME = "ThemeBloc_DARK_THEME";
  static ThemeBloc _singleton;
  SharedPreferences prefs;

  ThemeBloc._() {
    _loadSettings();
  }

  factory ThemeBloc() {
    if (_singleton == null) {
      _singleton = ThemeBloc._();
    }
    return _singleton;
  }

  @override
  ThemeState get initialState =>
      ThemeState(themeData: AppThemes.all[ThemeType.Light]);

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ChangeTheme) {
      _saveSettings(event.theme);
      yield ThemeState(themeData: AppThemes.all[event.theme]);
    }
  }

  _loadSettings() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    bool _darkTheme = prefs.getBool(DARK_THEME) ?? false;
    add(ChangeTheme(theme: _darkTheme ? ThemeType.Dark : ThemeType.Light));
    return _darkTheme;
  }

  _saveSettings(ThemeType themeType) async {
    bool darkTheme = themeType == ThemeType.Dark;
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    await prefs.setBool(DARK_THEME, darkTheme);
  }
}
