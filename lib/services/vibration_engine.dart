import 'package:flutter/services.dart';

class VibrationEngine {
  // Extracted core configuration tokens to prevent hardcoded literal duplication
  static const int _errorDelayMs = 100;
  
  // Guard flag used to protect physical hardware execution channels from thread-spamming
  static bool _isVibrating = false;

  /// Triggers a standard heavy tactile impact pattern upon successful execution paths
  static void success() {
    HapticFeedback.heavyImpact();
  }

  /// Triggers a subtle tactile pulse for basic user interface selections
  static void light() {
    HapticFeedback.lightImpact();
  }

  /// Executes a double-pulse tactile alert pattern wrapped in strict overlapping defenses
  static Future<void> error() async {
    // Drop execution immediately if a haptic sequence is already running
    if (_isVibrating) return;

    _isVibrating = true;
    try {
      await HapticFeedback.heavyImpact();
      
      // Delay track using extracted centralized design token dimensions
      await Future.delayed(const Duration(milliseconds: _errorDelayMs));
      
      await HapticFeedback.heavyImpact();
    } finally {
      // The finally block ensures the guard flag is reset even if the hardware layer encounters an error
      _isVibrating = false;
    }
  }
}
