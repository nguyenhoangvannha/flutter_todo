import 'package:equatable/equatable.dart';
import 'package:flutter_todo/domain/entity/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class FetchListTodo extends TodoEvent {
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final Todo todo;

  AddTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class ChangeTodoState extends TodoEvent {
  final Todo todo;

  ChangeTodoState(this.todo);

  @override
  List<Object> get props => [todo];
}
