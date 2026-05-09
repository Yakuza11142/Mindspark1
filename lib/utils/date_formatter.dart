import 'package:intl/intl.dart';
class DateFormatter {
  static String format(DateTime dt) => DateFormat('MMM d, y').format(dt);
}