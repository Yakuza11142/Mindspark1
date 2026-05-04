import 'package:flutter/material.dart';

class AppStateManager extends WidgetsBindingObserver {
  final VoidCallback onPaused;
  final VoidCallback onResumed;

  AppStateManager({required this.onPaused, required this.onResumed});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      print("App sent to background. Saving user progress to disk...");
      onPaused();
    } else if (state == AppLifecycleState.resumed) {
      print("App resumed. Reconnecting to sockets...");
      onResumed();
    }
  }
}