import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entity/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  TodoItem(this.todo);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      child: CheckboxListTile(
        value: _checked,
        selected: false,
        onChanged: (checked) {
          setState(() {
            _checked = checked;
          });
        },
        dense: true,
        secondary: Icon(Icons.account_box),
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(widget.todo.title),
      ),
    );
  }
}
