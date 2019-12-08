import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/ui/widget/add_todo_suggestion.dart';
import 'package:flutter_todo/ui/widget/todo_item.dart';

class TodoPanel extends StatelessWidget {
  final List<Todo> listTodo;

  TodoPanel(this.listTodo) : assert(listTodo != null);

  @override
  Widget build(BuildContext context) {
    return listTodo.isEmpty ? AddTodoSuggestion() : _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: _buildList(context, listTodo),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildList(BuildContext context, List<Todo> listTodo) {
    return ListView.separated(
        itemCount: listTodo.length,
        separatorBuilder: (bCtx, index) => Divider(
              height: 1,
            ),
        itemBuilder: (bCtx, index) {
          var todo = listTodo.elementAt(index);
          return TodoItem(
            todo,
            onCheckedChange: (checked) {
              todo.completed = checked;
              BlocProvider.of<TodoBloc>(context).add(UpdateTodo(todo));
            },
            onDelete: () {
              BlocProvider.of<TodoBloc>(context).add(DeleteTodo(todo));
            },
          );
        });
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        AppNavigator().showAddTodo(context);
      },
      child: Icon(Icons.add),
    );
  }
}
