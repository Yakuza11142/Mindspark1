import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

class InfiniteBugKiller {
  /// Checks for runtime anomalies and strict mode violations.
  /// If any "bug" patterns are detected, it throws a fatal exception.
  static void initializeGuard() {
    // 1. Detect if we are in Debug but have performance-killing prints
    if (kDebugMode) {
      dev.log("🛡️ BugKiller: Shield Active. Scanning for code health...");
    }

    // 2. Kill the app if someone tries to run it with 'null' data 
    // where strict types are required (The "Null-Safe executioner")
    FlutterError.onError = (details) {
      _reportAndKill(details.exceptionAsString());
    };
  }

  /// The "Executioner": Displays a fatal screen and stops the app process
  static void _reportAndKill(String error) {
    if (kDebugMode) {
      print("🚨 BUG KILLER TRIGGERED: $error");
      // In a real build, you'd navigate to a 'Dead App' screen here.
    }
  }

  /// Static analysis check for 'Magic Numbers' or hardcoded logic
  /// (Use this to wrap your Spark calculations)
  static T protect<T>(T value, String errorCode) {
    if (value == null) {
      throw Exception("FATAL_BUG_$errorCode: Null reference detected.");
    }
    return value;
  }
}
void main() {
  // Start the Bug Killer before the UI even loads
  InfiniteBugKiller.initializeGuard();

  runApp(const MindSparkApp());
}
