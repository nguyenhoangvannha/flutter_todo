import 'package:flutter/material.dart';
import 'package:flutter_todo/ui/widget/common/text.dart';

class BottomSheetAddTodo extends StatefulWidget {
  @override
  _BottomSheetAddTodoState createState() => _BottomSheetAddTodoState();
}

class _BottomSheetAddTodoState extends State<BottomSheetAddTodo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _processing = false;
  bool _alreadyInit = false;
  bool _checked = false;
  String _errorStr = "";
  final _textController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_alreadyInit) {
      _alreadyInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
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
                    child: TextFormField(
                      maxLines: 1,
                      autofocus: true,
                      controller: _textController,
                      validator: (value) {
                        if (value
                            .trim()
                            .isEmpty) {
                          return ('msg_text_required');
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: ('hint_add_todo'),
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
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          String todo = _textController.text;
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
    );
  }

  void _addTodo(BuildContext context, String title, bool completed) {
    setState(() {
      _processing = true;
    });
  }
}
