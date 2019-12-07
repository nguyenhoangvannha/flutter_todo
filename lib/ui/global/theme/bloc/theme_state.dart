import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData themeData;

  ThemeState({this.themeData});

  @override
  List<Object> get props => [themeData];
}
