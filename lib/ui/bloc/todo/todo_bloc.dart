import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';
import 'package:flutter_todo/ui/bloc/status.dart';

import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo _todoRepo;

  TodoBloc(this._todoRepo) : super(TodoState()) {
    on<FetchListTodo>((event, emit) async {
      try {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Loading()));
        final listAllTodo = await _todoRepo.getListTodo();
        print("listAllTodo");
        print(listAllTodo);
        emit(state.rebuild((p0) => p0
          ..statuses[event.statusKey] = Success()
          ..listAllTodo = MapBuilder(listAllTodo)
          ..listCompleteTodo =
              SetBuilder(_getListTodoByType(listAllTodo.values, true))
          ..listIncompleteTodo =
              SetBuilder(_getListTodoByType(listAllTodo.values, false))));
      } catch (e, s) {
        emit(state.rebuild((p0) =>
            p0..statuses[event.statusKey] = Error(message: e.toString())));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Loading()));
        await _todoRepo.addTodo(event.todo);
        emit(state.rebuild(
          (p0) => p0
            ..statuses[event.statusKey] = Success()
            ..todoId = event.todo.id,
        ));
      } catch (e, s) {
        emit(state.rebuild((p0) => p0
          ..statuses[event.statusKey] =
              Error(data: event.todo.id, message: e.toString())));
      } finally {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Idle(
              data: event.todo.id,
            )));
      }
    });
    on<UpdateTodo>((event, emit) async {
      try {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Loading()));
        await _todoRepo.updateTodo(event.todo);
        final todos =
            state.listAllTodo.rebuild((p0) => p0[event.todo.id] = event.todo);

        emit(state.rebuild((p0) => p0
          ..statuses[event.statusKey] = Success()
          ..listAllTodo = todos.toBuilder()
          ..listCompleteTodo =
              SetBuilder(_getListTodoByType(todos.values, true))
          ..listIncompleteTodo =
              SetBuilder(_getListTodoByType(todos.values, false))));
      } catch (e, s) {
        emit(state.rebuild((p0) => p0
          ..statuses[event.statusKey] =
              Error(data: event.todo.id, message: e.toString())));
      } finally {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Idle(
              data: event.todo.id,
            )));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Loading()));
        await _todoRepo.deleteTodo(event.todo);
        final todos = state.listAllTodo.rebuild(
            (p0) => p0.removeWhere((key, value) => key == event.todo.id));
        emit(state.rebuild((p0) => p0
          ..statuses[event.statusKey] = Success()
          ..listAllTodo = todos.toBuilder()
          ..listCompleteTodo =
              SetBuilder(_getListTodoByType(todos.values, true))
          ..listIncompleteTodo =
              SetBuilder(_getListTodoByType(todos.values, false))));
      } catch (e, s) {
        emit(state.rebuild((p0) => p0
          ..statuses[event.statusKey] =
              Error(data: event.todo.id, message: e.toString())));
      } finally {
        emit(state.rebuild((p0) => p0.statuses[event.statusKey] = Idle(
              data: event.todo.id,
            )));
      }
    });
  }

  Set<String> _getListTodoByType(Iterable<Todo> listTodo, bool _completed) {
    return listTodo
        .where((todo) {
          return todo.completed == _completed;
        })
        .map((e) => e.id)
        .toSet();
  }
}
