import 'package:intl/intl.dart';

class DateTimeFormat {
  static String formatDate(DateTime date, {String locale}) {
    try {
      return DateFormat.MMMd(locale ?? "en_EN").add_Hm().format(date);
    } catch (e) {
      return "";
    }
  }

  static String formatString(String dateStr, {String locale}) {
    try {
      DateTime date = DateTime.tryParse(dateStr);
      return DateFormat.MMMd(locale ?? "en_EN").add_Hm().format(date);
    } catch (e) {
      return "";
    }
  }
}
