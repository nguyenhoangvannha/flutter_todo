import 'package:flutter/material.dart';
import 'package:flutter_todo/component/routes.dart';
import 'package:flutter_todo/ui/screen/home_page.dart';

import 'component/app_injector.dart';

void main() {
  AppInjector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      routes: Routes().all,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => HomePage());
      },
    );
  }
}
