import 'app_localizations.dart';

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get app_name => 'Flutter Todo';

  @override
  String get act_add_todo => 'Thêm mới';

  @override
  String get act_try_again => 'Thử lại';

  @override
  String get title_settings => 'Cài đặt';

  @override
  String get title_themes_dark => 'Chủ đề tối';

  @override
  String get title_languages => 'Ngôn ngữ';

  @override
  String get title_complete_toto => 'Đã hoàn thành';

  @override
  String get title_incomplete_toto => 'Chưa hoàn thành';

  @override
  String get subtitle_add_date => 'Ngày thêm';

  @override
  String get msg_suggestion_no_todo => 'Bạn không có công việc cần làm nào!';

  @override
  String get msg_suggestion_no_complete => 'Không có công việc đã hoàn thành!';

  @override
  String get msg_suggestion_no_incomplete =>
      'Tất cả công việc đều đã hoàn tất?';

  @override
  String get msg_text_required => 'Vui lòng nhập việc cần làm';

  @override
  String get hint_add_todo => 'Thêm việc cần làm';

  @override
  String get en_EN => 'Tiếng Anh';

  @override
  String get vi_VN => 'Tiếng Việt';
}
