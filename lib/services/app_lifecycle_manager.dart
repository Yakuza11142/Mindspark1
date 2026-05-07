import 'package:flutter/material.dart';

class AppLifecycleManager extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("App in background. Pausing media to save battery.");
      // Trigger media pause event here
    }
  }
}