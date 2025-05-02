import 'package:intl/intl.dart';

class DateTimeUtils {
  // get formatted local time
  static String getFormattedLocalDateTime(String initial) {
    final DateTime dateTime = DateTime.parse(initial);
    final DateTime localDateTime = dateTime.toLocal();
    final String formattedDateTime = DateFormat('dd MMMM, yyyy, hh:mm a').format(localDateTime);
    return formattedDateTime;
  }
}
