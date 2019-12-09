import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TextTitle extends StatelessWidget {
  final String data;

  TextTitle(this.data) : assert(data != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    );
  }
}

class TextError extends StatelessWidget {
  final String data;

  TextError(this.data) : assert(data != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.title.copyWith(color: Colors.red),
    );
  }
}
