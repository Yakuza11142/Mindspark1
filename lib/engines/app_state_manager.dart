import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class AppStateManager extends WidgetsBindingObserver {
  final VoidCallback onPaused;
  final VoidCallback onResumed;
  
  bool _isRegistered = false;

  AppStateManager({required this.onPaused, required this.onResumed}) {
    // Offloaded binding registrations securely to execute post-frame initialization loops [INDEX]
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeLifecycleObserver();
    });
  }

  /// Explicitly hooks the observer instance into the native Flutter window scheduler loops [INDEX]
  void _initializeLifecycleObserver() {
    if (!_isRegistered) {
      WidgetsBinding.instance.addObserver(this);
      _isRegistered = true;
      developer.log("📱 AppStateManager: Lifecycle observer successfully bound to native engine hooks.");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        developer.log("⚙️ AppStateManager: App sent to background. Dispatching pause tracking sequences.");
        onPaused();
        break;
      case AppLifecycleState.resumed:
        developer.log("⚙️ AppStateManager: App returned to viewport. Dispatching resume synchronization sequences.");
        onResumed();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden: 
        break;
    }
  }

  /// Call this lifecycle teardown hook to safely decouple native observers and protect against memory leaks [INDEX]
  void dispose() {
    if (_isRegistered) {
      WidgetsBinding.instance.removeObserver(this);
      _isRegistered = false;
      developer.log("⚙️ AppStateManager: Lifecycle observer detached cleanly from window scheduler.");
    }
  }
}
