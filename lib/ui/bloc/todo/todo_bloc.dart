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
      var _listCompletedTodo = _listTodo.where((todo) {
        return todo.completed;
      }).toList();
      var _listInCompletedTodo = _listTodo.where((todo) {
        return !todo.completed;
      }).toList();
      yield FetchListTodoResult(
          listAllTodo: _listTodo,
          listCompleteTodo: _listCompletedTodo,
          listIncompleteTodo: _listInCompletedTodo);
    }
    if (event is AddTodo) {
      yield AddingTodo();
      _listTodo.insert(0, event.todo);
      yield AddTodoResult();
    }
    if (event is ChangeTodoState) {
      yield ChangingTodoState();
      _listTodo.firstWhere((element) {
        if (element.id == event.todo.id) {
          event.todo.completed = event.todo.completed;
        }
        return element.id == event.todo.id;
      });
      add(FetchListTodo());
      yield ChangeTodoStateResult();
    }
  }
}
