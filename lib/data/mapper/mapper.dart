import 'package:flutter_todo/data/db/moor_database.dart' as db;
import 'package:flutter_todo/domain/entity/todo.dart';

class Mapper {
  const Mapper();

  Todo mapDatabaseModelToTodo(db.Todo todo) {
    return Todo(todo.title,
        id: todo.id, completed: todo.completed, dateAdded: todo.dateAdded);
  }

  db.Todo mapTodoToDatabaseModel(Todo todo) {
    return db.Todo(
        title: todo.title,
        id: todo.id,
        completed: todo.completed,
        dateAdded: todo.dateAdded);
  }

  List<Todo> mapListDatabaseModelToTodo(List<db.Todo> listTodo) {
    return listTodo.map<Todo>((element) {
      return mapDatabaseModelToTodo(element);
    }).toList();
  }
}
