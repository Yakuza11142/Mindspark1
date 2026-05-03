import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DataLocalizationManager {
  /// Formats date for any country globally using standard locale codes (e.g., 'en_NG', 'en_US', 'fr_FR').
  static String formatDate(DateTime date, String locale) {
    // yMd() is a "skeleton" that auto-formats based on the provided locale.
    return DateFormat.yMd(locale).format(date);
  }

  /// Optional: Use this to ensure all locale data is loaded before formatting.
  static Future<void> init() async {
    await initializeDateFormatting();
  }
}
