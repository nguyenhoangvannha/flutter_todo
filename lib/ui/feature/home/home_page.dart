import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/src/l10n/app_localizations.dart';
import 'package:flutter_todo/ui/bloc/status.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/ui/widget/common/shimmer_list.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';
import 'package:flutter_todo/ui/widget/todo_panel.dart';

import '../../../component/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _alreadyInit = false;
  late int _selectedIndex;
  late AppLocalizations _translator;
  List<String> _appBarTitles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_alreadyInit) {
      _alreadyInit = true;
      _selectedIndex = 0;
      BlocProvider.of<TodoBloc>(context).add(FetchListTodo());
    }
    _translator = AppLocalizations.of(context);
    _appBarTitles.clear();
    _appBarTitles.add(_translator.app_name);
    _appBarTitles.add(_translator.title_incomplete_toto);
    _appBarTitles.add(_translator.title_complete_toto);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: _selectedIndex,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildBody(context),
        bottomNavigationBar: _buildBottomNavBar(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      leading: IconButton(
        icon: Icon(
          Icons.account_circle,
          size: 28,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Routes.SETTINGS);
        },
      ),
      title: Text(_appBarTitles[_selectedIndex]),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (bCtx, state) {
        final status = state.getStatus(FetchListTodo().statusKey);
        switch (status) {
          case Loading():
            return ShimmerList();
          case Idle():
          case Success():
            return _buildResult(
              context,
              state.listAllTodo.values.toList(),
              state.listAllTodo.values
                  .where(
                      (element) => state.listCompleteTodo.contains(element.id))
                  .toList(),
              state.listAllTodo.values
                  .where((element) =>
                      state.listIncompleteTodo.contains(element.id))
                  .toList(),
            );
          case Error():
            return _buildError(context, status.message);
        }
      },
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(0),
      shape: BeveledRectangleBorder(),
      child: TabBar(
          onTap: (position) {
            setState(() {
              _selectedIndex = position;
            });
          },
          labelColor: Theme.of(context).primaryColor,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.format_align_left)),
            Tab(icon: Icon(Icons.today)),
            Tab(icon: Icon(Icons.done_all)),
          ]),
    );
  }

  Widget _buildResult(BuildContext context, List<Todo> listAllTodo,
      List<Todo> listCompleteTodo, List<Todo> listIncompleteTodo) {
    return Container(
      child: TabBarView(
        children: <Widget>[
          TodoPanel(
            listAllTodo,
            suggestionMessage: _translator.msg_suggestion_no_todo,
          ),
          TodoPanel(
            listIncompleteTodo,
            suggestionMessage: _translator.msg_suggestion_no_incomplete,
          ),
          TodoPanel(
            listCompleteTodo,
            suggestionMessage: _translator.msg_suggestion_no_complete,
          )
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildError(BuildContext context, String exception) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextError(exception),
          SizedBox(
            height: 8,
          ),
          ElevatedButton(
              child: Text(_translator.act_try_again),
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(FetchListTodo());
              }),
        ],
      ),
    );
  }
}
