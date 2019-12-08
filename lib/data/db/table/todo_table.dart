import 'package:moor_flutter/moor_flutter.dart';

class Todos extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  BoolColumn get completed =>
      boolean().nullable().withDefault(Constant(false))();

  DateTimeColumn get dateAdded => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
