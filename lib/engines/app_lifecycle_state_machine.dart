import 'package:flutter/widgets.dart';

class AppLifecycleStateMachine extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden || state == AppLifecycleState.paused) {
      print("System sleeping. Memory flushed to disk.");
    }
  }
}