import 'package:flutter_todo/data/db/table/todo_table.dart';
import 'package:moor_flutter/moor_flutter.dart';

import 'dao/todo_dao.dart';

part 'moor_database.g.dart';

@UseMoor(tables: [Todos], daos: [TodoDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;
}
