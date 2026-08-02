import 'package:intl/intl.dart';

class DateFormatter {
  // Enforcing 'en_US' locale ensures uniform text lengths (e.g., 'Aug 2, 2026') across all devices
  static String format(DateTime dt) => DateFormat('MMM d, y', 'en_US').format(dt);
}
