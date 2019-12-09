import 'package:flutter/material.dart';
import 'package:flutter_todo/component/app_navigator.dart';
import 'package:flutter_todo/ui/global/localization/app_localizations.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';

class SuggestionAddTodo extends StatelessWidget {
  final String suggestionMessage;

  SuggestionAddTodo({this.suggestionMessage});

  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 56, right: 56),
            child: TextTitle(suggestionMessage ??
                trans.translate('msg_suggestion_no_todo')),
          ),
          SizedBox(
            height: 16,
          ),
          RaisedButton(
              child: Text(trans.translate('act_add_todo')),
              color: Theme.of(context).primaryColor,
              onPressed: () => AppNavigator().showAddTodo(context))
        ],
      ),
    );
  }
}
