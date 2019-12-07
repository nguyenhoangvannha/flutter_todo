import 'package:flutter/material.dart';
import 'package:flutter_todo/component/routes.dart';
import 'package:flutter_todo/ui/application.dart';
import 'package:flutter_todo/ui/feature/home/home_page.dart';

void main() {
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
          theme: initData.materialThemeData,
          supportedLocales: initData.supportedLocales,
          localizationsDelegates: initData.localizationsDelegates,
          localeResolutionCallback: initData.localeResolutionCallback,
          routes: Routes().all,
          onUnknownRoute: (settings) {
            return MaterialPageRoute(builder: (ctx) => HomePage());
          },
        );
      },
    );
  }
}
