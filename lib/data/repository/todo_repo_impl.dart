import 'package:flutter_todo/data/db/dao/todo_dao.dart';
import 'package:flutter_todo/data/mapper/mapper.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';

class TodoRepoImpl extends TodoRepo {
  static const int _TIME_OUT = 10;
  final TodoDao _todoDao;
  final Mapper mapper;

  TodoRepoImpl(this._todoDao, {this.mapper = const Mapper()});

  @override
  Future<Map<String, Todo>> getListTodo() async {
    final listTodo =
        await _todoDao.getAllTodo().timeout(Duration(seconds: _TIME_OUT));
    return mapper
        .mapListDatabaseModelToTodo(listTodo)
        .asMap()
        .map((key, value) => MapEntry(value.id, value));
  }

  @override
  Future<int> addTodo(Todo todo) async {
    final todoId = await _todoDao
        .insertTodo(mapper.mapTodoToDatabaseModel(todo))
        .timeout(Duration(seconds: _TIME_OUT));
    return todoId;
  }

  @override
  Future<int> deleteTodo(Todo todo) async {
    return await _todoDao
        .deleteTodo(mapper.mapTodoToDatabaseModel(todo))
        .timeout(Duration(seconds: _TIME_OUT));
  }

  @override
  Future<bool> updateTodo(Todo todo) async {
    return await _todoDao
        .updateTodo(mapper.mapTodoToDatabaseModel(todo))
        .timeout(Duration(seconds: _TIME_OUT));
  }
}
