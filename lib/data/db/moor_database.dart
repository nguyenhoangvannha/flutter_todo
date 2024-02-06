import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:flutter_todo/data/db/table/todo_table.dart';
import 'package:drift/drift.dart';

import 'dao/todo_dao.dart';

part 'moor_database.g.dart';

@DriftDatabase(tables: [Todos])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((SqfliteQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 1;
}
