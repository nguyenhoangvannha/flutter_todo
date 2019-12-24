import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/screen/home_page.dart';

class Routes {
  static Routes _singleton;

  static const String MAIN = '/';
  static const String SETTINGS = '/settings';

  Routes._();

  factory Routes() {
    if (_singleton == null) {
      _singleton = Routes._();
    }
    return _singleton;
  }

  Map<String, WidgetBuilder> get all {
    return {
      MAIN: (bCtx) => HomePage(),
    };
  }
}
