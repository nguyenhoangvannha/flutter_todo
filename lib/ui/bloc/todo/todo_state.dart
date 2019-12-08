import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
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
  final List<Todo> listAllTodo;
  final List<Todo> listCompleteTodo;
  final List<Todo> listIncompleteTodo;

  FetchListTodoResult({@required this.listAllTodo,
    @required this.listCompleteTodo,
    @required this.listIncompleteTodo});

  @override
  List<Object> get props => [listAllTodo, listCompleteTodo, listIncompleteTodo];
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

class UpdatingTodo extends TodoState {
  @override
  List<Object> get props => [];
}

class UpdateTodoError extends TodoState {
  final Exception exception;

  UpdateTodoError(this.exception);

  @override
  List<Object> get props => [];
}

class UpdateTodoResult extends TodoState {
  @override
  List<Object> get props => [];
}

class DeletingTodoTodo extends TodoState {
  @override
  List<Object> get props => [];
}

class DeleteTodoError extends TodoState {
  final Exception exception;

  DeleteTodoError(this.exception);

  @override
  List<Object> get props => [];
}

class DeleteTodoResult extends TodoState {
  @override
  List<Object> get props => [];
}