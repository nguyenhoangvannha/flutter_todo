import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/util/date_time_format.dart';

import '../../src/l10n/app_localizations.dart';

class TodoItem extends StatefulWidget {
  final Function(bool? checked) onCheckedChange;
  final Function() onDelete;
  final Todo todo;

  TodoItem(this.todo, {required this.onCheckedChange, required this.onDelete});

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool? _checked = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations trans = AppLocalizations.of(context);
    _checked = widget.todo.completed;
    String addDate = DateTimeFormat.formatDate(widget.todo.dateAdded,
        locale: Localizations.localeOf(context));
    return Card(
      margin: EdgeInsets.all(0),
      shape: BeveledRectangleBorder(),
      child: ListTile(
        leading: Checkbox(value: _checked, onChanged: _onCheckedChange),
        title: Text(widget.todo.title),
        subtitle: Text(trans.subtitle_add_date + " " + addDate),
        trailing: IconButton(
            icon: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            onPressed: widget.onDelete),
      ),
    );
  }

  void _onCheckedChange(bool? checked) {
    setState(() {
      _checked = checked;
    });
    if (widget.onCheckedChange != null) {
      widget.onCheckedChange(checked);
    }
  }
}
