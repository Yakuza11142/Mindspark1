import 'dart:async';

class TimeoutHandler {
  static Future<T?> run<T>(Future<T> action) async {
    try {
      return await action.timeout(const Duration(seconds: 15));
    } on TimeoutException {
      print("API Timed Out.");
      return null;
    }
  }
}