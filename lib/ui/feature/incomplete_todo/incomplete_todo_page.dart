import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';

class IncompleteTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextTitle("Todos"),
        Expanded(
            child: ListView(
              children: <Widget>[
              ],
            ))
      ],
    );
  }
}
