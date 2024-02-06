import 'package:flutter_todo/src/l10n/app_localizations.dart';

extension L10NExt on AppLocalizations {
  String languageName(String languageCode) {
    switch (languageCode) {
      case 'en':
        return en_EN;
      case 'vi':
        return vi_VN;
      default:
        return '';
    }
  }
}
