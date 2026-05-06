import 'package:flutter/material.dart';
import 'package:supabase_crashlytics/supabase_crashlytics.dart';

class ErrorBoundary {
  static void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      // 1. Send bug to Supabase silently
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      
      // 2. Prevent the red screen of death
      FlutterError.dumpErrorToConsole(details);
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: const Text(
          "Optimizing interface...", 
          style: TextStyle(color: Colors.cyanAccent, fontSize: 12),
          textDirection: TextDirection.ltr,
        ),
      );
    };
  }
}