import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/component/routes.dart';
import 'package:flutter_todo/src/l10n/app_localizations.dart';
import 'package:flutter_todo/ui/application.dart';
import 'package:flutter_todo/ui/feature/home/home_page.dart';

import 'component/app_injector.dart';

class BlocObs extends BlocObserver {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    log("onEvent $event, ${bloc.state}");
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    log("onChange ${change.currentState}, ${change.nextState}");
    super.onChange(bloc, change);
  }
}

void main() {
  AppInjector.init();
  Bloc.observer = BlocObs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Application(
      builder: (bCtx, initData) {
        return MaterialApp(
          title: 'Flutter Todo',
          locale: initData.locale,
          themeMode: initData.materialThemeData,
          darkTheme: ThemeData.dark(),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routes: Routes().all,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => HomePage());
          },
        );
      },
    );
  }
}
