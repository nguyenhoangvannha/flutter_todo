import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo/domain/repository/todo_repo.dart';
import 'package:flutter_todo/ui/bloc/todo/bloc.dart';
import 'package:flutter_todo/ui/bloc/todo/todo_bloc.dart';
import 'package:flutter_todo/ui/global/theme/bloc/theme_bloc.dart';
import 'package:injector/injector.dart';

import 'global/localization/bloc/localizations_bloc.dart';
import 'global/localization/bloc/localizations_state.dart';

//This widget contains  init data, theme and locale manager and provide that data to child widget
class Application extends StatelessWidget {
  final Widget Function(BuildContext context, InitData initData) builder;

  Application({required this.builder});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoBloc>(
            create: (bCtx) => TodoBloc(Injector.appInstance.get<TodoRepo>())),
        BlocProvider<ThemeBloc>(
          create: (bCtx) => ThemeBloc(),
        ),
        BlocProvider<LocalizationsBloc>(
            create: (BuildContext context) => LocalizationsBloc()),
      ],
      child: BlocBuilder<LocalizationsBloc, LocalizationsState>(
          builder: (bCtx, localeState) {
        return BlocBuilder<ThemeBloc, ThemeMode>(builder: (_, themeMode) {
          InitData initData = InitData(
            themeMode,
            localeState.locale,
          );
          return builder(bCtx, initData);
        });
      }),
    );
  }
}

class InitData {
  ThemeMode materialThemeData;
  Locale locale;

  InitData(this.materialThemeData, this.locale);
}
