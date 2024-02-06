// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TodoState extends TodoState {
  @override
  final BuiltMap<String, Status> statuses;
  @override
  final BuiltMap<String, Todo> listAllTodo;
  @override
  final BuiltSet<String> listCompleteTodo;
  @override
  final BuiltSet<String> listIncompleteTodo;
  @override
  final String todoId;

  factory _$TodoState([void Function(TodoStateBuilder)? updates]) =>
      (new TodoStateBuilder()..update(updates))._build();

  _$TodoState._(
      {required this.statuses,
      required this.listAllTodo,
      required this.listCompleteTodo,
      required this.listIncompleteTodo,
      required this.todoId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(statuses, r'TodoState', 'statuses');
    BuiltValueNullFieldError.checkNotNull(
        listAllTodo, r'TodoState', 'listAllTodo');
    BuiltValueNullFieldError.checkNotNull(
        listCompleteTodo, r'TodoState', 'listCompleteTodo');
    BuiltValueNullFieldError.checkNotNull(
        listIncompleteTodo, r'TodoState', 'listIncompleteTodo');
    BuiltValueNullFieldError.checkNotNull(todoId, r'TodoState', 'todoId');
  }

  @override
  TodoState rebuild(void Function(TodoStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoStateBuilder toBuilder() => new TodoStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TodoState &&
        statuses == other.statuses &&
        listAllTodo == other.listAllTodo &&
        listCompleteTodo == other.listCompleteTodo &&
        listIncompleteTodo == other.listIncompleteTodo &&
        todoId == other.todoId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, statuses.hashCode);
    _$hash = $jc(_$hash, listAllTodo.hashCode);
    _$hash = $jc(_$hash, listCompleteTodo.hashCode);
    _$hash = $jc(_$hash, listIncompleteTodo.hashCode);
    _$hash = $jc(_$hash, todoId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TodoState')
          ..add('statuses', statuses)
          ..add('listAllTodo', listAllTodo)
          ..add('listCompleteTodo', listCompleteTodo)
          ..add('listIncompleteTodo', listIncompleteTodo)
          ..add('todoId', todoId))
        .toString();
  }
}

class TodoStateBuilder implements Builder<TodoState, TodoStateBuilder> {
  _$TodoState? _$v;

  MapBuilder<String, Status>? _statuses;
  MapBuilder<String, Status> get statuses =>
      _$this._statuses ??= new MapBuilder<String, Status>();
  set statuses(MapBuilder<String, Status>? statuses) =>
      _$this._statuses = statuses;

  MapBuilder<String, Todo>? _listAllTodo;
  MapBuilder<String, Todo> get listAllTodo =>
      _$this._listAllTodo ??= new MapBuilder<String, Todo>();
  set listAllTodo(MapBuilder<String, Todo>? listAllTodo) =>
      _$this._listAllTodo = listAllTodo;

  SetBuilder<String>? _listCompleteTodo;
  SetBuilder<String> get listCompleteTodo =>
      _$this._listCompleteTodo ??= new SetBuilder<String>();
  set listCompleteTodo(SetBuilder<String>? listCompleteTodo) =>
      _$this._listCompleteTodo = listCompleteTodo;

  SetBuilder<String>? _listIncompleteTodo;
  SetBuilder<String> get listIncompleteTodo =>
      _$this._listIncompleteTodo ??= new SetBuilder<String>();
  set listIncompleteTodo(SetBuilder<String>? listIncompleteTodo) =>
      _$this._listIncompleteTodo = listIncompleteTodo;

  String? _todoId;
  String? get todoId => _$this._todoId;
  set todoId(String? todoId) => _$this._todoId = todoId;

  TodoStateBuilder();

  TodoStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _statuses = $v.statuses.toBuilder();
      _listAllTodo = $v.listAllTodo.toBuilder();
      _listCompleteTodo = $v.listCompleteTodo.toBuilder();
      _listIncompleteTodo = $v.listIncompleteTodo.toBuilder();
      _todoId = $v.todoId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TodoState;
  }

  @override
  void update(void Function(TodoStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TodoState build() => _build();

  _$TodoState _build() {
    TodoState._init(this);
    _$TodoState _$result;
    try {
      _$result = _$v ??
          new _$TodoState._(
              statuses: statuses.build(),
              listAllTodo: listAllTodo.build(),
              listCompleteTodo: listCompleteTodo.build(),
              listIncompleteTodo: listIncompleteTodo.build(),
              todoId: BuiltValueNullFieldError.checkNotNull(
                  todoId, r'TodoState', 'todoId'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'statuses';
        statuses.build();
        _$failedField = 'listAllTodo';
        listAllTodo.build();
        _$failedField = 'listCompleteTodo';
        listCompleteTodo.build();
        _$failedField = 'listIncompleteTodo';
        listIncompleteTodo.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            r'TodoState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
