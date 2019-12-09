import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/util/resource.dart';
import 'package:mockito/mockito.dart';

class MockTodoRepo extends Mock implements TodoRepo {}

void main() {
  MockTodoRepo mockTodoRepo;
  TodoBloc todoBloc;
  setUp(() {
    mockTodoRepo = MockTodoRepo();
    todoBloc = TodoBloc(mockTodoRepo);
  });

  group("fetch_list_todo", () {
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits init,fetching,result",
      build: () {
        when(mockTodoRepo.getListTodo()).thenAnswer(
            (_) async => DataResource(ResourceType.Success, data: []));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(FetchListTodo()),
      expect: [
        InitialTodoState(),
        FetchingListTodo(),
        FetchListTodoResult(
            listAllTodo: [], listCompleteTodo: [], listIncompleteTodo: [])
      ],
    );
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits init,fetching,error when exception",
      build: () {
        when(mockTodoRepo.getListTodo()).thenAnswer((_) async =>
            DataResource(ResourceType.Error, exception: Exception()));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(FetchListTodo()),
      expect: [
        InitialTodoState(),
        FetchingListTodo(),
        FetchListTodoError(Exception())
      ],
    );
  });

  final todo =
      Todo("Go to school", id: 1, completed: false, dateAdded: DateTime.now());

  group("add_todo", () {
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,Loading,Result",
      build: () {
        when(mockTodoRepo.addTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
            (_) async => DataResource(ResourceType.Success, data: 1));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(AddTodo(todo)),
      expect: [InitialTodoState(), Loading(1), Result(todo.id)],
    );
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits initialTodoState,Loading,Error when exception",
      build: () {
        when(mockTodoRepo.addTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
            (_) async =>
                DataResource(ResourceType.Error, exception: Exception()));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(AddTodo(todo)),
      expect: [InitialTodoState(), Loading(1), Error(Exception(), 1)],
    );
  });

  group("update_todo", () {
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,Loading,Result",
      build: () {
        when(mockTodoRepo.updateTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
                (_) async =>
                DataResource(ResourceType.Success,
                    data: true));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(UpdateTodo(todo)),
      expect: [InitialTodoState(), Loading(1), Result(todo.id)],
    );
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,Loading,Error",
      build: () {
        when(mockTodoRepo.updateTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
                (_) async =>
                DataResource(ResourceType.Error, exception: Exception()));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(UpdateTodo(todo)),
      expect: [InitialTodoState(), Loading(1), Error(Exception(), todo.id)],
    );
  });

  group("delete_todo", () {
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,Loading,Result",
      build: () {
        when(mockTodoRepo.deleteTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
            (_) async => DataResource(ResourceType.Success, data: 1));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(DeleteTodo(todo)),
      expect: [InitialTodoState(), Loading(todo.id), Result(todo.id)],
    );

    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,Loading,Error",
      build: () {
        when(mockTodoRepo.deleteTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
                (_) async =>
                DataResource(ResourceType.Error, exception: Exception()));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(DeleteTodo(todo)),
      expect: [InitialTodoState(), Loading(todo.id), Error(Exception(), 1)],
    );
  });
}
