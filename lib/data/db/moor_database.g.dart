// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String title;
  final bool completed;
  final DateTime dateAdded;

  Todo(
      {@required this.id,
      @required this.title,
      this.completed,
      @required this.dateAdded});

  factory Todo.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return Todo(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      completed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}completed']),
      dateAdded: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}date_added']),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      completed: serializer.fromJson<bool>(json['completed']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
    );
  }

  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'completed': serializer.toJson<bool>(completed),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
    };
  }

  @override
  TodosCompanion createCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      dateAdded: dateAdded == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAdded),
    );
  }

  Todo copyWith({int id, String title, bool completed, DateTime dateAdded}) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        completed: completed ?? this.completed,
        dateAdded: dateAdded ?? this.dateAdded,
      );

  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('completed: $completed, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(title.hashCode, $mrjc(completed.hashCode, dateAdded.hashCode))));

  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.title == this.title &&
          other.completed == this.completed &&
          other.dateAdded == this.dateAdded);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> title;
  final Value<bool> completed;
  final Value<DateTime> dateAdded;

  const TodosCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.completed = const Value.absent(),
    this.dateAdded = const Value.absent(),
  });

  TodosCompanion.insert({
    @required int id,
    @required String title,
    this.completed = const Value.absent(),
    @required DateTime dateAdded,
  })  : id = Value(id),
        title = Value(title),
        dateAdded = Value(dateAdded);

  TodosCompanion copyWith(
      {Value<int> id,
      Value<String> title,
      Value<bool> completed,
      Value<DateTime> dateAdded}) {
    return TodosCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      dateAdded: dateAdded ?? this.dateAdded,
    );
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  final GeneratedDatabase _db;
  final String _alias;

  $TodosTable(this._db, [this._alias]);

  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;

  @override
  GeneratedIntColumn get id => _id ??= _constructId();

  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;

  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();

  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _completedMeta = const VerificationMeta('completed');
  GeneratedBoolColumn _completed;

  @override
  GeneratedBoolColumn get completed => _completed ??= _constructCompleted();

  GeneratedBoolColumn _constructCompleted() {
    return GeneratedBoolColumn('completed', $tableName, true,
        defaultValue: Constant(false));
  }

  final VerificationMeta _dateAddedMeta = const VerificationMeta('dateAdded');
  GeneratedDateTimeColumn _dateAdded;

  @override
  GeneratedDateTimeColumn get dateAdded => _dateAdded ??= _constructDateAdded();

  GeneratedDateTimeColumn _constructDateAdded() {
    return GeneratedDateTimeColumn(
      'date_added',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, title, completed, dateAdded];

  @override
  $TodosTable get asDslTable => this;

  @override
  String get $tableName => _alias ?? 'todos';
  @override
  final String actualTableName = 'todos';

  @override
  VerificationContext validateIntegrity(TodosCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.completed.present) {
      context.handle(_completedMeta,
          completed.isAcceptableValue(d.completed.value, _completedMeta));
    } else if (completed.isRequired && isInserting) {
      context.missing(_completedMeta);
    }
    if (d.dateAdded.present) {
      context.handle(_dateAddedMeta,
          dateAdded.isAcceptableValue(d.dateAdded.value, _dateAddedMeta));
    } else if (dateAdded.isRequired && isInserting) {
      context.missing(_dateAddedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Todo map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Todo.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TodosCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.completed.present) {
      map['completed'] = Variable<bool, BoolType>(d.completed.value);
    }
    if (d.dateAdded.present) {
      map['date_added'] = Variable<DateTime, DateTimeType>(d.dateAdded.value);
    }
    return map;
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $TodosTable _todos;

  $TodosTable get todos => _todos ??= $TodosTable(this);
  TodoDao _todoDao;

  TodoDao get todoDao => _todoDao ??= TodoDao(db: this as AppDatabase);

  @override
  List<TableInfo> get allTables => [todos];
}
