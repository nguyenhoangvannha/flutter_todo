import 'package:flutter_todo/data/db/dao/todo_dao.dart';
import 'package:flutter_todo/data/mapper/mapper.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';
import 'package:flutter_todo/util/resource.dart';

class TodoRepoImpl extends TodoRepo {
  static const int _TIME_OUT = 10;
  final TodoDao _todoDao;
  final Mapper mapper;

  TodoRepoImpl(this._todoDao, {this.mapper = const Mapper()});

  @override
  Future<DataResource<List<Todo>>> getListTodo() async {
    try {
      final listTodo =
          await _todoDao.getAllMovies().timeout(Duration(seconds: _TIME_OUT));
      return DataResource(ResourceType.Success,
          data: mapper.mapListDatabaseModelToTodo(listTodo));
    } catch (ex) {
      if (ex is Exception) {
        return DataResource(ResourceType.Error, exception: ex);
      } else {
        return DataResource(ResourceType.Error,
            exception: Exception(ex.toString()));
      }
    }
  }

  @override
  Future<DataResource<int>> addTodo(Todo todo) async {
    try {
      final todoId = await _todoDao
          .insertTodo(mapper.mapTodoToDatabaseModel(todo))
          .timeout(Duration(seconds: _TIME_OUT));
      return DataResource(ResourceType.Success, data: todoId);
    } catch (ex) {
      if (ex is Exception) {
        return DataResource(ResourceType.Error, exception: ex);
      } else {
        return DataResource(ResourceType.Error,
            exception: Exception(ex.toString()));
      }
    }
  }

  @override
  Future<DataResource<int>> deleteTodo(Todo todo) async {
    try {
      final todoId = await _todoDao
          .deleteTodo(mapper.mapTodoToDatabaseModel(todo))
          .timeout(Duration(seconds: _TIME_OUT));
      return DataResource(ResourceType.Success, data: todoId);
    } catch (ex) {
      if (ex is Exception) {
        return DataResource(ResourceType.Error, exception: ex);
      } else {
        return DataResource(ResourceType.Error,
            exception: Exception(ex.toString()));
      }
    }
  }

  @override
  Future<DataResource<bool>> updateTodo(Todo todo) async {
    try {
      final result = await _todoDao
          .updateTodo(mapper.mapTodoToDatabaseModel(todo))
          .timeout(Duration(seconds: _TIME_OUT));
      return DataResource(ResourceType.Success, data: result);
    } catch (ex) {
      if (ex is Exception) {
        return DataResource(ResourceType.Error, exception: ex);
      } else {
        return DataResource(ResourceType.Error,
            exception: Exception(ex.toString()));
      }
    }
  }
}
