import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/feature/home/home_page.dart';
import 'package:flutter_todo/ui/feature/settings/settings_page.dart';

class Routes {
  static const String MAIN = '/';
  static const String SETTINGS = '/settings';

  Map<String, WidgetBuilder> get all {
    return {
      MAIN: (bCtx) => HomePage(),
      SETTINGS: (bCtx) => SettingsPage(),
    };
  }
}
