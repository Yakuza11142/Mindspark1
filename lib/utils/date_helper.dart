import 'package:intl/intl.dart';

class DateHelper {
  // Adding an optional parameter allows for predictable unit testing and mock data validation
  static String getToday([DateTime? customDate]) {
    final targetDate = customDate ?? DateTime.now();
    return DateFormat('yyyy-MM-dd', 'en_US').format(targetDate);
  }
}
