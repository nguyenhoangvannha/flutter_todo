import 'package:flutter_todo/data/db/dao/todo_dao.dart';
import 'package:flutter_todo/data/db/moor_database.dart';
import 'package:flutter_todo/data/repository/todo_repo_impl.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';
import 'package:injector/injector.dart';

class AppInjector {
  static void init() {
    Injector.appInstance.registerSingleton<AppDatabase>((injector) {
      return AppDatabase();
    });

    Injector.appInstance.registerSingleton<TodoDao>((injector) {
      return TodoDao(db: injector.getDependency());
    });

    Injector.appInstance.registerSingleton<TodoRepo>((injector) {
      TodoRepo repo = TodoRepoImpl(injector.getDependency());
      return repo;
    });
  }
}
