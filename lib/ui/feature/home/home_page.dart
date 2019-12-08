import 'package:flutter/material.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/ui/feature/all_todo/all_todo_page.dart';
import 'package:flutter_todo/ui/feature/complete_todo/complete_todo_page.dart';
import 'package:flutter_todo/ui/feature/incomplete_todo/incomplete_todo_page.dart';
import 'package:flutter_todo/ui/feature/search/simple_search_delegate.dart';
import 'package:flutter_todo/ui/global/localization/app_localizations.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
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
      title: Text(AppLocalizations.of(context).translate('app_name')),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.search,
              size: 28,
            ),
            onPressed: () {
              showSearch(context: context, delegate: SimpleSearchDelegate());
            })
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: TabBarView(children: <Widget>[
        AllTodoPage(),
        IncompleteTodoPage(),
        CompleteTodoPage()
      ]),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(0),
      shape: BeveledRectangleBorder(),
      child: TabBar(labelColor: Theme.of(context).primaryColor, tabs: <Widget>[
        Tab(icon: Icon(Icons.format_align_left)),
        Tab(icon: Icon(Icons.today)),
        Tab(icon: Icon(Icons.done_all)),
      ]),
    );
  }
}
