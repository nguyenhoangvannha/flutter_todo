import 'package:flutter/material.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';
import 'package:flutter_todo/ui/widget/todo_panel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _alreadyInit = false;
  int _selectedIndex;
  List<String> _appBarTitles = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_alreadyInit) {
      _alreadyInit = true;
      _selectedIndex = 0;
    }
    _appBarTitles.clear();
    _appBarTitles.add(('app_name'));
    _appBarTitles.add(('title_incomplete_toto'));
    _appBarTitles.add(('title_complete_toto'));
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
    return _buildResult(context, [], [], []);
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
            suggestionMessage: ('msg_suggestion_no_todo'),
          ),
          TodoPanel(
            listIncompleteTodo,
            suggestionMessage:
            ('msg_suggestion_no_incomplete'),
          ),
          TodoPanel(
            listCompleteTodo,
            suggestionMessage:
            ('msg_suggestion_no_complete'),
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
              child: Text(('act_try_again')),
              color: Colors.green,
              onPressed: () {
                //BlocProvider.of<TodoBloc>(context).add(FetchListTodo());
              }),
        ],
      ),
    );
  }
}
