import 'package:intl/intl.dart';

class DateConvert {
  static DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  static DateFormat dateFormatRequest = DateFormat("yyyy-MM-dd");

  static String dateTimeToString(DateTime dateTime) {
    return dateFormat.format(dateTime);
  }

  static String dateTimeToStringRequest(DateTime dateTime) {
    return dateFormatRequest.format(dateTime);
  }

  static DateTime stringToDateTime(String dateTime) {
    return dateFormat.parse(dateTime);
  }

  static DateTime stringToDateTimeRequest(String dateTime) {
    return dateFormatRequest.parse(dateTime);
  }

  static String stringFormatToRequest(String dateTimeString) {
    DateTime dateTime = dateFormat.parse(dateTimeString);
    return dateFormatRequest.format(dateTime);
  }

  static String reversedDateTimeString(String dateTimeString) {
    return dateTimeString.split('-').reversed.join('-');
  }
}
