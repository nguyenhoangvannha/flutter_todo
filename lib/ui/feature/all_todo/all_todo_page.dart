import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_bloc.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_event.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_state.dart';
import 'package:flutter_todo/ui/widget/add_todo_suggestion.dart';
import 'package:flutter_todo/ui/widget/common/shimmer_list.dart';
import 'package:flutter_todo/ui/widget/todo_item.dart';

class AllTodoPage extends StatefulWidget {
  @override
  _AllTodoPageState createState() => _AllTodoPageState();
}

class _AllTodoPageState extends State<AllTodoPage>
    with AutomaticKeepAliveClientMixin {
  bool _alreadyInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_alreadyInit) {
      _alreadyInit = true;
      BlocProvider.of<TodoBloc>(context).add(FetchListTodo());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TodoBloc, TodoState>(condition: (pre, cur) {
      return cur is FetchingListTodo ||
          cur is FetchListTodoError ||
          cur is FetchListTodoResult;
    }, builder: (bCtx, state) {
      if (state is FetchingListTodo) {
        return ShimmerList();
      }
      if (state is FetchListTodoResult) {
        if (state.listTodo.isEmpty) {
          return AddTodoSuggestion();
        } else {
          return _buildResult(context, state.listTodo);
        }
      }
      return Container();
    });
  }

  Widget _buildResult(BuildContext context, List<Todo> listTodo) {
    return Scaffold(
      body: _buildBody(context, listTodo),
      floatingActionButton: _buildFloatingButton(context),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => AppNavigator().showAddTodo(context),
    );
  }

  Widget _buildBody(BuildContext context, List<Todo> listTodo) {
    return ListView.builder(
        itemCount: listTodo.length,
        itemBuilder: (bCtx, index) {
          return TodoItem(listTodo.elementAt(index));
        });
  }

  @override
  bool get wantKeepAlive => true;
}
