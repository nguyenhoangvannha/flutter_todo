import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/util/resource.dart';

abstract class TodoRepo {
  Future<DataResource<List<Todo>>> getListTodo();

  Future<DataResource<int>> addTodo(Todo todo);

  Future<DataResource<bool>> updateTodo(Todo todo);

  Future<DataResource<int>> deleteTodo(Todo todo);
}
