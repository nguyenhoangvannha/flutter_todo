import 'package:drift/drift.dart';

class Todos extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  BoolColumn get completed => boolean().withDefault(Constant(false))();

  DateTimeColumn get dateAdded => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
