import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_todo/domain/entity/todo.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_bloc.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_event.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_state.dart';
import 'package:flutter_todo/ui/global/localization/app_localizations.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';

class BottomSheetAddTodo extends StatefulWidget {
  @override
  _BottomSheetAddTodoState createState() => _BottomSheetAddTodoState();
}

class _BottomSheetAddTodoState extends State<BottomSheetAddTodo> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TodoBloc _todoBloc;
  bool _processing = false;
  bool _alreadyInit = false;
  bool _checked = false;
  String _errorStr = "";
  AppLocalizations _trans;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_alreadyInit) {
      _alreadyInit = true;
      _todoBloc = BlocProvider.of<TodoBloc>(context);
      _trans = AppLocalizations.of(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      autovalidate: true,
      child: Card(
        elevation: 8,
        margin: EdgeInsets.all(0),
        shape: BeveledRectangleBorder(),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              if (_errorStr.isNotEmpty) TextError(_errorStr),
              Row(
                children: <Widget>[
                  Checkbox(
                      value: _checked,
                      onChanged: (checked) {
                        setState(() {
                          _checked = checked;
                        });
                      }),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: FormBuilderTextField(
                      attribute: "todo",
                      maxLines: 1,
                      autofocus: true,
                      validators: [
                        (value) {
                          if (value.trim().isEmpty) {
                            return _trans.translate('msg_text_required');
                          }
                          return null;
                        }
                      ],
                      decoration: InputDecoration(
                          hintText: _trans.translate('hint_add_todo'),
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _buildAddButton(context),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              if (_processing) LinearProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return BlocListener<TodoBloc, TodoState>(
      condition: (pre, cur) {
        return cur is Loading || cur is Error || cur is Result;
      },
      listener: (bCtx, state) {
        if (state is! Loading) {
          setState(() {
            _processing = false;
          });
        }
        if (state is Error) {
          setState(() {
            _errorStr = state.exception.toString();
          });
        }
        if (state is Result) {
          _todoBloc.add(FetchListTodo());
          Navigator.of(context).pop();
        }
      },
      child: InkWell(
        onTap: () {
          if (_formKey.currentState.saveAndValidate()) {
            String todo = _formKey.currentState.value['todo'];
            _addTodo(context, todo, _checked);
          }
        },
        child: Card(
            margin: EdgeInsets.all(0),
            color: Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(Icons.arrow_upward),
            )),
      ),
    );
  }

  void _addTodo(BuildContext context, String title, bool completed) {
    setState(() {
      _processing = true;
    });
    _todoBloc.add(AddTodo(Todo(title, completed: completed)));
  }
}
