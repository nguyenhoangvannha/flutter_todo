import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/data/db/dao/todo_dao.dart';
import 'package:flutter_todo/data/db/moor_database.dart' as db;
import 'package:flutter_todo/data/mapper/mapper.dart';
import 'package:flutter_todo/data/repository/todo_repo_impl.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:mockito/mockito.dart';

class MockTodoDao extends Mock implements TodoDao {}

void main() {
  TodoRepoImpl todoRepo;
  MockTodoDao mockTodoDao;
  Mapper mapper = Mapper();
  setUp(() {
    mockTodoDao = MockTodoDao();
    todoRepo = TodoRepoImpl(mockTodoDao, mapper: mapper);
  });

  final List<db.Todo> listTodoOrigin = generateListTodoOrigin(10);

  final Todo todoToAdd =
      Todo("This is a new todo", id: 2019, dateAdded: DateTime.now());

  final firstItem = listTodoOrigin.elementAt(0);
  final Todo firstTodoInList = mapper.mapDatabaseModelToTodo(firstItem);

  group("GetListTodo", () {
    test("Should return list of todo resource", () async {
      when(mockTodoDao.getAllTodo()).thenAnswer((_) async => listTodoOrigin);
      final result = await todoRepo.getListTodo();
      verify(mockTodoDao.getAllTodo());
      expect(result.type, ResourceType.Success);
      expect(result.data, isInstanceOf<List<Todo>>());
      expect(result.exception, isNull);
    });

    test("Should return time out exception resource", () async {
      when(mockTodoDao.getAllTodo()).thenThrow(TimeoutException("Time out"));
      final result = await todoRepo.getListTodo();
      verify(mockTodoDao.getAllTodo());
      expect(result.type, ResourceType.Error);
      expect(result.data, isNull);
      expect(result.exception, isNotNull);
    });
  });

  group("AddTodo", () {
    test("Shoud add todo to list and return insertid", () async {
      when(mockTodoDao.insertTodo(argThat(isInstanceOf<db.Todo>())))
          .thenAnswer((invocation) async {
        db.Todo t = invocation.positionalArguments[0];
        return t.id;
      });
      final result = await todoRepo.addTodo(todoToAdd);
      verify(mockTodoDao.insertTodo(any));
      expect(result.type, ResourceType.Success);
      expect(result.data, todoToAdd.id);
      expect(result.exception, isNull);
    });

    test("Shoud not add duplicate todo", () async {
      when(mockTodoDao.insertTodo(argThat(isInstanceOf<db.Todo>())))
          .thenThrow(Exception("Duplicate"));
      final result = await todoRepo.addTodo(firstTodoInList);
      verify(mockTodoDao.insertTodo(any));
      expect(result.type, ResourceType.Error);
      expect(result.data, isNull);
      expect(result.exception, isNotNull);
      expect(result.exception.toString(), "Exception: Duplicate");
    });

    test("Shoud return exception", () async {
      when(mockTodoDao.insertTodo(argThat(isInstanceOf<db.Todo>())))
          .thenThrow("Some error");
      final result = await todoRepo.addTodo(todoToAdd);
      verify(mockTodoDao.insertTodo(any));
      expect(result.type, ResourceType.Error);
      expect(result.data, isNull);
      expect(result.exception, isNotNull);
      expect(result.exception.toString(), "Exception: Some error");
    });
  });

  group("UpdateTodo", () {
    test("Shoud update todo", () async {
      when(mockTodoDao.updateTodo(argThat(isInstanceOf<db.Todo>())))
          .thenAnswer((invocation) async => true);
      final result = await todoRepo.updateTodo(firstTodoInList);
      verify(mockTodoDao.updateTodo(any));
      expect(result.type, ResourceType.Success);
      expect(result.data, true);
      expect(result.exception, isNull);
    });

    test("Shoud update todo error", () async {
      when(mockTodoDao.updateTodo(argThat(isInstanceOf<db.Todo>())))
          .thenAnswer((invocation) async => false);
      var notInListTodo = mapper.mapDatabaseModelToTodo(
          listTodoOrigin.elementAt(0).copyWith(id: 9999));
      final result = await todoRepo.updateTodo(notInListTodo);
      verify(mockTodoDao.updateTodo(any));
      expect(result.type, ResourceType.Success);
      expect(result.data, false);
      expect(result.exception, isNull);
    });

    test("Shoud have exception update todo", () async {
      when(mockTodoDao.updateTodo(argThat(isInstanceOf<db.Todo>())))
          .thenThrow(Exception());
      final result = await todoRepo.updateTodo(firstTodoInList);
      verify(mockTodoDao.updateTodo(any));
      expect(result.data, isNull);
      expect(result.exception, isNotNull);
    });
  });

  group("DeleteTodo", () {
    test("Shoud delete first todo", () async {
      when(mockTodoDao.deleteTodo(argThat(isInstanceOf<db.Todo>())))
          .thenAnswer((invocation) async {
        final arg = invocation.positionalArguments[0];
        return arg.id;
      });
      final result = await todoRepo.deleteTodo(firstTodoInList);
      expect(result.type, ResourceType.Success);
      expect(result.data, firstTodoInList.id);
      expect(result.exception, isNull);
    });

    test("Shoud not delete unknow todo", () async {
      when(mockTodoDao.deleteTodo(argThat(isInstanceOf<db.Todo>())))
          .thenThrow(Exception("Notfound"));
      final unknownTodo = mapper.mapDatabaseModelToTodo(
          listTodoOrigin.elementAt(1).copyWith(id: 99999));
      final result = await todoRepo.deleteTodo(unknownTodo);
      expect(result.type, ResourceType.Error);
      expect(result.data, isNull);
      expect(result.exception, isNotNull);
    });
  });
}

List<db.Todo> generateListTodoOrigin(int length) {
  List<db.Todo> results = List<db.Todo>();
  for (int i = 0; i < length; i++) {
    results.add(db.Todo(
        id: i, title: "Generated todo - ${i}", dateAdded: DateTime.now()));
  }
  return results;
}
