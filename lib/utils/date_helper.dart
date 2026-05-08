import 'package:intl/intl.dart';
class DateHelper {
  static String getToday() => DateFormat('yyyy-MM-dd').format(DateTime.now());
}