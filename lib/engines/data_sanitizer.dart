import 'dart:developer' as developer;

class DataSanitizer {
  // Optimized comprehensive tracking pattern to catch and clean characters natively in one step [INDEX]
  static final RegExp _dangerousCharsPattern = RegExp(r'[<>/{}[\]~`\\]');
  
  // Strips zero-width and invisible look-alike characters anywhere they are positioned in the text string [INDEX]
  static final RegExp _globalInvisiblePattern = RegExp(r'[\u200b\u200c\u200d\ufeff\u3000]');

  /// Cleanses user-supplied text inputs aggressively to safeguard application entry boundaries [INDEX]
  static String cleanInput(String rawInput) {
    if (rawInput.isEmpty) return "";

    try {
      // 1. Eliminate the dangerous do-while loop to secure against CPU Starvation/DoS attacks [INDEX]
      // Running a simple global replaceAll on a character class executes in linear time O(n) natively [INDEX]
      String sanitized = rawInput.replaceAll(_dangerousCharsPattern, '');

      // 2. Clear out tricky zero-width and multi-byte invisible markers globally across all lines [INDEX]
      sanitized = sanitized.replaceAll(_globalInvisiblePattern, '');

      // 3. Complete standard ASCII space edge trimming safely [INDEX]
      return sanitized.trim();
    } catch (e, stackTrace) {
      developer.log("❌ DataSanitizer: Sanitization execution flow crashed unexpectedly", error: e, stackTrace: stackTrace);
      return ""; 
    }
  }
}
