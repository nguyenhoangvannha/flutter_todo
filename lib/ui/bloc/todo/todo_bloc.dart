import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todo/domain/entity/todo.dart';

import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final List<Todo> _listTodo = List<Todo>();

  @override
  TodoState get initialState => InitialTodoState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is FetchListTodo) {
      yield FetchingListTodo();
      await Future.delayed(Duration(seconds: 1));
      yield FetchListTodoResult(_listTodo);
    }
    if (event is AddTodo) {
      yield AddingTodo();
      await Future.delayed(Duration(seconds: 1));
      _listTodo.add(event.todo);
      yield AddTodoResult();
    }
    if (event is ChangeTodoState) {
      yield AddingTodo();
      await Future.delayed(Duration(seconds: 1));
      _listTodo.firstWhere((element) {
        if (element.id == event.todo.id) {
          event.todo.completed = event.todo.completed;
        }
        return element.id == event.todo.id;
      });
      yield ChangeTodoStateResult();
    }
  }
}
