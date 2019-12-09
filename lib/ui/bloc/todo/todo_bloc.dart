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

  List<Todo> _listTodo = [];

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is FetchListTodo) {
      if (_listTodo != null && _listTodo.isNotEmpty) {
        yield FetchListTodoResult(
            listAllTodo: _listTodo,
            listCompleteTodo: _getListTodoByType(_listTodo, true),
            listIncompleteTodo: _getListTodoByType(_listTodo, false));
      } else {
        yield FetchingListTodo();
        var res = await _todoRepo.getListTodo();
        switch (res.type) {
          case ResourceType.Error:
            yield FetchListTodoError(res.exception);
            break;
          case ResourceType.Success:
            _listTodo = res.data;
            yield FetchListTodoResult(
                listAllTodo: _listTodo,
                listCompleteTodo: _getListTodoByType(_listTodo, true),
                listIncompleteTodo: _getListTodoByType(_listTodo, false));
            break;
        }
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
          _listTodo.insert(0, event.todo);
          yield AddTodoResult(event.todo.id);
          break;
      }
    }
    if (event is UpdateTodo) {
      yield UpdatingTodo(event.todo.id);
      var res = await _todoRepo.updateTodo(event.todo);
      switch (res.type) {
        case ResourceType.Error:
          yield UpdateTodoError(res.exception, event.todo.id);
          break;
        case ResourceType.Success:
          _listTodo.firstWhere((todo) {
            if (todo.id == event.todo.id) {
              todo.completed = event.todo.completed;
              return true;
            }
            return false;
          });
          add(FetchListTodo());
          yield UpdateTodoResult(event.todo.id);
          break;
      }
    }
    if (event is DeleteTodo) {
      yield DeletingTodo(event.todo.id);
      var res = await _todoRepo.deleteTodo(event.todo);
      switch (res.type) {
        case ResourceType.Error:
          yield DeleteTodoError(res.exception, event.todo.id);
          break;
        case ResourceType.Success:
          _listTodo.removeWhere((m) {
            return m.id == event.todo.id;
          });
          add(FetchListTodo());
          yield DeleteTodoResult(event.todo.id);
          break;
      }
    }
  }

  List<Todo> _getListTodoByType(List<Todo> listTodo, bool _completed) {
    return listTodo.where((todo) {
      return todo.completed == _completed;
    }).toList();
  }
}
