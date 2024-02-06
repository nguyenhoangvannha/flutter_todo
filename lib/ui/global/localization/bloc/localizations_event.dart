import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LocalizationsEvent extends Equatable {
  const LocalizationsEvent();
}

class LocaleChanged extends LocalizationsEvent {
  final Locale locale;

  LocaleChanged({required this.locale});

  @override
  List<Object> get props => [locale.languageCode];
}
