import 'package:flutter/widgets.dart';

class AppResumeRefresher extends WidgetsBindingObserver {
  final VoidCallback onResume;
  AppResumeRefresher(this.onResume);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }
}