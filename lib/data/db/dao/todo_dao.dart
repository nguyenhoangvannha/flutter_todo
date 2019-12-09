import 'package:flutter_todo/data/db/table/todo_table.dart';
import 'package:moor_flutter/moor_flutter.dart';

import '../moor_database.dart';

part 'todo_dao.g.dart';

@UseDao(tables: [Todos])
class TodoDao extends DatabaseAccessor<AppDatabase> with _$TodoDaoMixin {
  AppDatabase db;

  TodoDao({@required this.db}) : super(db);

  Future<List<Todo>> getAllTodo() => select(todos).get();

  Future<int> insertTodo(Insertable<Todo> todo) => into(todos).insert(todo);

  Future<bool> updateTodo(Insertable<Todo> todo) => update(todos).replace(todo);

  Future<int> deleteTodo(Insertable<Todo> todo) => delete(todos).delete((todo));
}
