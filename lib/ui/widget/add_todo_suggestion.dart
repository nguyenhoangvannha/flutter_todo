import 'package:flutter/material.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';

class AddTodoSuggestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextTitle("You have no todo yet!"),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
              child: Text("Add new todo"),
              color: Theme.of(context).primaryColor,
              onPressed: () => AppNavigator().showAddTodo(context))
        ],
      ),
    );
  }
}
