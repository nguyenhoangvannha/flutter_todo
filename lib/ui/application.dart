import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global/localization/ui/locale_builder.dart';
import 'global/theme/theme_builder.dart';

//This widget contains  init data, theme and locale manager and provide that data to child widget
class Application extends StatelessWidget {
  final Widget Function(BuildContext context, InitData initData) builder;

  Application({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return LocaleBuilder(
      builder: (bCtx, locale, supportedLocales, localizationsDelegates,
          localeResolutionCallback) {
        return ThemeBuilder(
          builder: (bCtx, themeData) {
            InitData initData = InitData(themeData, locale, supportedLocales,
                localizationsDelegates, localeResolutionCallback);
            return builder(bCtx, initData);
          },
        );
      },
    );
  }
}

class InitData {
  ThemeData materialThemeData;
  Locale locale;
  List<Locale> supportedLocales;
  List<LocalizationsDelegate> localizationsDelegates;
  Function localeResolutionCallback;

  InitData(this.materialThemeData, this.locale, this.supportedLocales,
      this.localizationsDelegates, this.localeResolutionCallback);
}
