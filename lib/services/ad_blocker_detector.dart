import 'dart:io';

class AdBlockerDetector {
  static Future<bool> isAdBlockActive() async {
    try {
      // Try to resolve Google Ads DNS
      final result = await InternetAddress.lookup('googleadservices.com');
      return result.isEmpty;
    } catch (_) {
      return true; // Likely blocked
    }
  }
}