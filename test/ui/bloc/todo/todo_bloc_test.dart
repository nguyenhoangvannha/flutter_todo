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

  group("FetchListTodo", () {
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

  group("AddTodo", () {
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,AddingTodo,AddTodoResult",
      build: () {
        when(mockTodoRepo.addTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
            (_) async => DataResource(ResourceType.Success, data: 1));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(AddTodo(todo)),
      expect: [InitialTodoState(), Loading(1), Result(todo.id)],
    );
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits initialTodoState,AddingTodo,AddTodoError when exception",
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

  group("DeleteTodo", () {
    blocTest<TodoBloc, TodoEvent, TodoState>(
      "emits InitialTodoState,DeletingTodo,DeleteTodoResult",
      build: () {
        when(mockTodoRepo.deleteTodo(argThat(isInstanceOf<Todo>()))).thenAnswer(
            (_) async => DataResource(ResourceType.Success, data: 1));
        return todoBloc;
      },
      act: (bloc) async => bloc.add(DeleteTodo(todo)),
      expect: [
        InitialTodoState(),
        Loading(todo.id),
        Result(todo.id)
      ],
    );
  });
}
