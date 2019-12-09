import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/ui/global/localization/app_localizations.dart';
import 'package:flutter_todo/ui/widget/common/shimmer_list.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';
import 'package:flutter_todo/ui/widget/todo_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _alreadyInit = false;
  int _selectedIndex;
  AppLocalizations _translator;
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
    _appBarTitles.add(_translator.translate('app_name'));
    _appBarTitles.add(_translator.translate('title_incomplete_toto'));
    _appBarTitles.add(_translator.translate('title_complete_toto'));
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

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).canvasColor,
      textTheme: Theme.of(context).textTheme,
      iconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: Theme.of(context).primaryColor),
      leading: IconButton(
        icon: Icon(
          Icons.account_circle,
          size: 28,
        ),
        onPressed: () => AppNavigator().navToSettings(context),
      ),
      title: Text(_appBarTitles[_selectedIndex]),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(condition: (pre, cur) {
      return cur is FetchingListTodo ||
          cur is FetchListTodoError ||
          cur is FetchListTodoResult;
    }, builder: (bCtx, state) {
      if (state is FetchingListTodo) {
        return ShimmerList();
      }

      if (state is FetchListTodoError) {
        return _buildError(context, state.exception);
      }

      if (state is FetchListTodoResult) {
        return _buildResult(context, state.listAllTodo, state.listCompleteTodo,
            state.listIncompleteTodo);
      }
      return Container();
    });
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
          labelColor: Theme
              .of(context)
              .primaryColor,
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
            suggestionMessage: _translator.translate('msg_suggestion_no_todo'),
          ),
          TodoPanel(
            listIncompleteTodo,
            suggestionMessage:
            _translator.translate('msg_suggestion_no_incomplete'),
          ),
          TodoPanel(
            listCompleteTodo,
            suggestionMessage:
            _translator.translate('msg_suggestion_no_complete'),
          )
        ],
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }

  Widget _buildError(BuildContext context, Exception exception) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextError(exception.toString()),
          SizedBox(
            height: 8,
          ),
          RaisedButton(
              child: Text(_translator.translate('act_try_again')),
              color: Colors.green,
              onPressed: () {
                BlocProvider.of<TodoBloc>(context).add(FetchListTodo());
              }),
        ],
      ),
    );
  }
}
