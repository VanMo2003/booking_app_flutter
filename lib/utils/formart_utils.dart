import 'package:intl/intl.dart';

class FormartUtils {
  static String formatDoubleToVND(double amount) {
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    return formatter.format(amount);
  }
}
