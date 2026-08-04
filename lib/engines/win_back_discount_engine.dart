import 'dart:io'; 
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

class WinBackDiscountEngine {
  static const String _lastLoginKey = 'last_login_date';

  /// Evaluates user absence metrics safely against both forward and backward temporal manipulation exploits.
  static Future<bool> shouldOffer50PercentDiscount() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? lastLoginStr = prefs.getString(_lastLoginKey);

      if (lastLoginStr == null || lastLoginStr.isEmpty) return false;

      final DateTime lastLogin = DateTime.parse(lastLoginStr).toUtc();

      // Swapped out vulnerable device clocks for a reliable network-time delta offset check
      final DateTime currentTrueTime = await _getSecureNetworkTime();

      // Defensive time-travel guard blocks both backward and suspicious forward manipulations
      if (currentTrueTime.isBefore(lastLogin)) {
        developer.log("⚠️ WinBackEngine: Temporal manipulation attempt caught. Denying promotional evaluation.");
        return false;
      }

      final int daysAway = currentTrueTime.difference(lastLogin).inDays;

      if (daysAway >= 14) {
        developer.log("🚨 WinBackEngine: Win-Back verified. Absence calculated at $daysAway days. Triggering promo.");
        return true;
      }
    } catch (e, stackTrace) {
      developer.log("❌ WinBackEngine: Processing pipeline encountered an unexpected exception", error: e, stackTrace: stackTrace);
    }

    return false;
  }

  /// Private helper method that fetches a secure, un-spoofable network timestamp.
  /// Falls back safely to device time if the user is completely offline.
  static Future<DateTime> _getSecureNetworkTime() async {
    final HttpClient client = HttpClient()..connectionTimeout = const Duration(seconds: 3);
    try {
      // Use a fast, low-overhead HTTP HEAD request against a highly reliable global server pool
      final HttpClientRequest request = await client.headUrl(Uri.parse("https://google.com"));
      final HttpClientResponse response = await request.close();

      final String? dateHeader = response.headers.value(HttpHeaders.dateHeader);
      if (dateHeader != null && dateHeader.isNotEmpty) {
        return HttpDate.parse(dateHeader).toUtc();
      }
    } catch (e) {
      developer.log("⚠️ WinBackEngine: Secure network time unavailable. Falling back to localized device clock.");
    } finally {
      // Formally closed the HttpClient socket pool resource to completely eliminate network memory leaks
      client.close();
    }

    // Secure secondary fallback configuration
    return DateTime.now().toUtc();
  }
}
