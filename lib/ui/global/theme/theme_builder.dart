import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/ui/global/theme/bloc/theme_bloc.dart';
import 'package:flutter_todo/ui/global/theme/bloc/theme_state.dart';

class ThemeBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  ThemeBuilder({@required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (bCtx) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (bCtx, state) {
        return builder(bCtx, state.themeData);
      }),
    );
  }
}
