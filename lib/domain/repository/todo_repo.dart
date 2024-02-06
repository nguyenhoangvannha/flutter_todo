import 'package:flutter_todo/domain/entity/todo.dart';

abstract class TodoRepo {
  Future<Map<String, Todo>> getListTodo();

  Future<int> addTodo(Todo todo);

  Future<bool> updateTodo(Todo todo);

  Future<int> deleteTodo(Todo todo);
}
