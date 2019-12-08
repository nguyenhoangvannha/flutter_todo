import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/component/routes.dart';
import 'package:flutter_todo/ui/widget/add_todo_widget.dart';

class AppNavigator {
  static AppNavigator _singleton;

  AppNavigator._();

  factory AppNavigator() {
    if (_singleton == null) {
      _singleton = AppNavigator._();
    }
    return _singleton;
  }

  void navToSettings(BuildContext context) {
    Navigator.pushNamed(context, Routes.SETTINGS);
  }

  void showAddTodo(BuildContext context) {
    Scaffold.of(context).showBottomSheet(
            (bCtx) => AddTodoWidget());
  }
}
