import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/ui/widget/suggestion_add_todo.dart';
import 'package:flutter_todo/ui/widget/todo_item.dart';
import 'package:flutter_todo/ui/bloc/status.dart';

import 'bottom_sheet_add_todo.dart';

class TodoPanel extends StatelessWidget {
  final List<Todo> listTodo;
  final String suggestionMessage;

  TodoPanel(this.listTodo, {required this.suggestionMessage})
      : assert(listTodo != null);

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
      listenWhen: (pre, cur) {
        return cur is Error &&
            (listTodo.indexWhere((item) => item.id == cur.todoId) >= 0);
      },
      listener: (bCtx, state) {
        final status = state.getStatus("UpdateTodo");
        if (status is Error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error ${status.message}"),
          ));
          var item = listTodo.firstWhere((item) => item.id == state.todoId);
          item.completed = !item.completed;
        }
      },
      child: ListView.separated(
          itemCount: listTodo.length,
          separatorBuilder: (bCtx, index) => Divider(
                height: 1,
              ),
          itemBuilder: (bCtx, index) {
            var todo = listTodo.elementAt(index);
            return TodoItem(
              todo,
              onCheckedChange: (checked) {
                todo.completed = checked ?? false;
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
        Scaffold.of(context).showBottomSheet((bCtx) => BottomSheetAddTodo());
      },
      child: Icon(Icons.add),
    );
  }
}
