import 'dart:async';

class ApiRetryHelper {
  static Future<T> runWithRetry<T>(Future<T> Function() apiCall, {int retries = 7}) async {
    int attempts = 0;
    while (attempts < retries) {
      try {
        return await apiCall();
      } catch (e) {
        attempts++;
        if (attempts >= retries) rethrow;
        await Future.delayed(Duration(seconds: attempts * 2)); // Exponential backoff
      }
    }
    throw Exception("Failed after $retries attempts");
  }
}