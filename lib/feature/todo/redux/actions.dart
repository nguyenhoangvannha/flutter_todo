import 'package:flutter_todo/domain/entity/todo.dart';

abstract class TodoAction {
  const TodoAction();
}

class FetchListTodo extends TodoAction {}

class AddTodo extends TodoAction {
  final Todo todo;

  AddTodo(this.todo);
}

class UpdateTodo extends TodoAction {
  final Todo todo;

  UpdateTodo(this.todo);
}

class DeleteTodo extends TodoAction {
  final Todo todo;

  DeleteTodo(this.todo);
}
