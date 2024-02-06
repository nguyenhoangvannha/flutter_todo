import 'package:flutter_todo/domain/entity/todo.dart';

import 'package:built_collection/built_collection.dart';
import "package:built_value/built_value.dart";
import 'package:flutter_todo/ui/bloc/status.dart';

part 'todo_state.g.dart';

abstract class TodoState implements Built<TodoState, TodoStateBuilder> {
  TodoState._();

  BuiltMap<String, Status> get statuses;

  BuiltMap<String, Todo> get listAllTodo;

  BuiltSet<String> get listCompleteTodo;

  BuiltSet<String> get listIncompleteTodo;

  String get todoId;

  @BuiltValueHook(initializeBuilder: true)
  static void _init(TodoStateBuilder b) => b
    ..statuses = MapBuilder()
    ..listAllTodo = MapBuilder()
    ..listCompleteTodo = SetBuilder()
    ..listIncompleteTodo = SetBuilder()
    ..todoId = "";

  factory TodoState([void Function(TodoStateBuilder) updates]) = _$TodoState;
}

extension e on TodoState {
  Status getStatus(String key) {
    return statuses[key] ?? Idle();
  }
}
