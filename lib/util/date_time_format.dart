import 'dart:ui';

import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatDate(DateTime date, {required Locale locale}) {
    try {
      return DateFormat.MMMd(locale.toString()).add_Hm().format(date);
    } catch (e) {
      return "";
    }
  }
}
