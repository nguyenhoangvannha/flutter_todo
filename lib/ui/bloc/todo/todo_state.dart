import 'package:equatable/equatable.dart';
import 'package:flutter_todo/domain/entity/todo.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class InitialTodoState extends TodoState {
  @override
  List<Object> get props => [];
}

class FetchingListTodo extends TodoState {
  @override
  List<Object> get props => [];
}

class FetchListTodoError extends TodoState {
  final Exception exception;

  FetchListTodoError(this.exception);

  @override
  List<Object> get props => [exception];
}

class FetchListTodoResult extends TodoState {
  final List<Todo> listTodo;

  FetchListTodoResult(this.listTodo);

  @override
  List<Object> get props => [listTodo];
}

class AddingTodo extends TodoState {
  @override
  List<Object> get props => [];
}

class AddTodoError extends TodoState {
  final Exception exception;

  AddTodoError(this.exception);

  @override
  List<Object> get props => [exception];
}

class AddTodoResult extends TodoState {
  @override
  List<Object> get props => [];
}

class ChangingTodoState extends TodoState {
  @override
  List<Object> get props => [];
}

class ChangeTodoStateError extends TodoState {
  @override
  List<Object> get props => [];
}

class ChangeTodoStateResult extends TodoState {
  @override
  List<Object> get props => [];
}
