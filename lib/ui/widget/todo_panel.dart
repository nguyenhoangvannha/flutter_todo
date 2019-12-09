import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/ui/widget/suggestion_add_todo.dart';
import 'package:flutter_todo/ui/widget/todo_item.dart';

class TodoPanel extends StatelessWidget {
  final List<Todo> listTodo;
  final String suggestionMessage;

  TodoPanel(this.listTodo, {this.suggestionMessage}) : assert(listTodo != null);

  @override
  Widget build(BuildContext context) {
    return listTodo.isEmpty
        ? SuggestionAddTodo(
      suggestionMessage: this.suggestionMessage,
    )
        : _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      body: _buildList(context, listTodo),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildList(BuildContext context, List<Todo> listTodo) {
    return BlocListener<TodoBloc, TodoState>(
      condition: (pre, cur) {
        return cur is Error &&
            (listTodo.indexWhere((item) => item.id == cur.todoId) >= 0);
      },
      listener: (bCtx, state) {
        if (state is Error) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Error ${state.exception.toString()}"),
          ));
          var item = listTodo.firstWhere((item) => item.id == state.todoId);
          item.completed = !item.completed;
        }
      },
      child: ListView.separated(
          itemCount: listTodo.length,
          separatorBuilder: (bCtx, index) =>
              Divider(
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
          }),
    );
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
