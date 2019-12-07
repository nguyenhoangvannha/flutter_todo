import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LightTheme {
  static final ThemeData material =
      ThemeData(brightness: Brightness.light, primarySwatch: Colors.deepPurple);
  static final CupertinoThemeData cupertino =
      CupertinoThemeData(brightness: Brightness.light);
}
