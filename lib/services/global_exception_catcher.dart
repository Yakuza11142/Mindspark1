import 'dart:async';
class GlobalExceptionCatcher {
  static void init(Function appRunner) {
    runZonedGuarded(() => appRunner(), (error, stack) {
      print("🔥 FATAL ERROR CAUGHT IN ZONE: $error");
    });
  }
}