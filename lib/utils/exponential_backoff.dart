import 'dart:async';
import 'dart:math';

class ExponentialBackoff {
  static Future<T> execute<T>(Future<T> Function() task, {int maxAttempts = 5}) async {
    int attempt = 0;
    while (attempt < maxAttempts) {
      try {
        return await task();
      } catch (e) {
        attempt++;
        if (attempt >= maxAttempts) rethrow;
        int delay = pow(2, attempt).toInt();
        print("Network failed. Retrying in $delay seconds...");
        await Future.delayed(Duration(seconds: delay));
      }
    }
    throw Exception("Max retries reached.");
  }
}