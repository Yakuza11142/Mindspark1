import 'package:flutter/material.dart';

class GlobalErrorHandler {
  static void init() {
    FlutterError.onError = (FlutterErrorDetails details) {
      // Log to console
      print("CRITICAL ERROR CAUGHT: ${details.exception}");
      // In production, send to Firebase Crashlytics here
    };
  }

  static Widget fallbackWidget() {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("Rebooting MindSpark Interface...", style: TextStyle(color: Colors.amber))),
    );
  }
}