import 'dart:ui';

import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatDate(DateTime date, {Locale locale}) {
    try {
      return DateFormat.MMMd(locale?.toString() ?? "en_EN")
          .add_Hm()
          .format(date);
    } catch (e) {
      return "";
    }
  }

  static String formatString(String dateStr, {String localeStr}) {
    try {
      DateTime date = DateTime.tryParse(dateStr);
      return DateFormat.MMMd(localeStr ?? "en_EN").add_Hm().format(date);
    } catch (e) {
      return "";
    }
  }
}
