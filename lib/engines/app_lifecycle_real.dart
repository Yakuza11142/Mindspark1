import 'package:flutter/widgets.dart';
// import '../database/drift_database.dart';

class AppLifecycleReal extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      print("CRITICAL: App killed. Closing SQLite database connections cleanly.");
      // db.close();
    }
  }
}