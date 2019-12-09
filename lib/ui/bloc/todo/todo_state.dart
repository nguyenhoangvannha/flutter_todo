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
  List<Object> get props => [exception.toString()];
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

class Loading extends TodoState {
  final int todoId;

  Loading(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class Error extends TodoState {
  final Exception exception;
  final int todoId;

  Error(this.exception, this.todoId);

  @override
  List<Object> get props => [todoId];
}

class Result extends TodoState {
  final int todoId;

  Result(this.todoId);

  @override
  List<Object> get props => [todoId];
}

//class AddingTodo extends TodoState {
//  @override
//  List<Object> get props => [];
//}
//
//class AddTodoError extends TodoState {
//  final Exception exception;
//
//  AddTodoError(this.exception);
//
//  @override
//  List<Object> get props => [exception.toString()];
//}
//
//class AddTodoResult extends TodoState {
//  final int insertId;
//
//  AddTodoResult(this.insertId);
//
//  @override
//  List<Object> get props => [insertId];
//}


//
//class DeletingTodo extends TodoState {
//  final int todoId;
//
//  DeletingTodo(this.todoId);
//
//  @override
//  List<Object> get props => [todoId];
//}
//
//class DeleteTodoError extends TodoState {
//  final int todoId;
//  final Exception exception;
//
//  DeleteTodoError(this.exception, this.todoId);
//
//  @override
//  List<Object> get props => [todoId];
//}
//
//class DeleteTodoResult extends TodoState {
//  final int todoId;
//
//  DeleteTodoResult(this.todoId);
//
//  @override
//  List<Object> get props => [todoId];
//}