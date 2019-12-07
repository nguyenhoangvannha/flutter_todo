import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/ui/global/theme/theme_data/app_themes.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ChangeTheme extends ThemeEvent {
  final ThemeType theme;

  @override
  List<Object> get props => [theme];

  ChangeTheme({@required this.theme});
}
