import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';
import 'package:flutter_todo/util/resource.dart';

import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo _todoRepo;

  TodoBloc(this._todoRepo);

  @override
  TodoState get initialState => InitialTodoState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is FetchListTodo) {
      yield FetchingListTodo();
      var res = await _todoRepo.getListTodo();
      switch (res.type) {
        case ResourceType.Error:
          yield FetchListTodoError(res.exception);
          break;
        case ResourceType.Success:
          final List<Todo> _listTodo = res.data;
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
          break;
      }
    }
    if (event is AddTodo) {
      yield AddingTodo();
      var res = await _todoRepo.addTodo(event.todo);
      switch (res.type) {
        case ResourceType.Error:
          yield AddTodoError(res.exception);
          break;
        case ResourceType.Success:
          yield AddTodoResult();
          break;
      }
    }
    if (event is UpdateTodo) {
      var res = await _todoRepo.updateTodo(event.todo);
      switch (res.type) {
        case ResourceType.Error:
          yield UpdateTodoError(res.exception);
          break;
        case ResourceType.Success:
          add(FetchListTodo());
          yield UpdateTodoResult();
          break;
      }
    }
  }
}
