import 'package:flutter_todo/ui/global/theme/theme_data/dark_theme.dart';
import 'package:flutter_todo/ui/global/theme/theme_data/light_theme.dart';

enum ThemeType { Dark, Light }

class AppThemes {
  static final all = {
    ThemeType.Light: LightTheme.material,
    ThemeType.Dark: DarkTheme.material
  };
}
