import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'Flutter Todo';

  @override
  String get act_add_todo => 'Add todo';

  @override
  String get act_try_again => 'Try again';

  @override
  String get title_settings => 'Settings';

  @override
  String get title_themes_dark => 'Dark theme';

  @override
  String get title_languages => 'Language';

  @override
  String get title_complete_toto => 'Completed';

  @override
  String get title_incomplete_toto => 'Incomplete';

  @override
  String get subtitle_add_date => 'Add date';

  @override
  String get msg_suggestion_no_todo => 'You have no todo!';

  @override
  String get msg_suggestion_no_complete => 'You have no completed todo!';

  @override
  String get msg_suggestion_no_incomplete => 'You have no incomplete todo!';

  @override
  String get msg_text_required => 'Please enter some text';

  @override
  String get hint_add_todo => 'Add todo';

  @override
  String get en_EN => 'English';

  @override
  String get vi_VN => 'Vietnamese';
}
