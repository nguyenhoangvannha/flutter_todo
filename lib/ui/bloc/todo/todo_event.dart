import 'package:equatable/equatable.dart';
import 'package:flutter_todo/domain/entity/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class FetchListTodo extends TodoEvent {
  String get statusKey => "FetchListTodo";
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  String get statusKey => "AddTodo";
  final Todo todo;

  AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodoEvent {
  String get statusKey => "UpdateTodo";
  final Todo todo;

  UpdateTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodoEvent {
  String get statusKey => "DeleteTodo";
  final Todo todo;

  DeleteTodo(this.todo);

  @override
  List<Object> get props => [todo];
}
