import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';

import '../../src/l10n/app_localizations.dart';
import 'bottom_sheet_add_todo.dart';

class SuggestionAddTodo extends StatelessWidget {
  final String suggestionMessage;

  SuggestionAddTodo({required this.suggestionMessage});

  @override
  Widget build(BuildContext context) {
    final trans = AppLocalizations.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 56, right: 56),
            child: TextTitle(suggestionMessage ?? trans.msg_suggestion_no_todo),
          ),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
              child: Text(trans.act_add_todo),
              onPressed: () {
                Scaffold.of(context)
                    .showBottomSheet((bCtx) => BottomSheetAddTodo());
              }),
        ],
      ),
    );
  }
}
