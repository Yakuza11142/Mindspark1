import 'dart:async';
import 'package:flutter/foundation.dart';

class SttSilenceDetector {
  // FIXED: Restored the structural callback field required to pass compilation steps
  final VoidCallback onSilenceDetected;
  
  Timer? _silenceTimer;
  bool _isActive = false;

  SttSilenceDetector({required this.onSilenceDetected});

  /// Starts or refreshes the silence detection interval ticker
  void resetTimer() {
    _silenceTimer?.cancel();
    _isActive = true;

    // OPTIMIZED: 1.5 to 2.5 seconds is the pedagogical sweet spot for conversational AI pacing.
    // This gives the student room to breathe without prematurely severing the connection pipeline.
    _silenceTimer = Timer(const Duration(milliseconds: 2000), () {
      if (!_isActive) return;
      
      debugPrint("🎙️ [AetherCore STT] Silence threshold reached. Closing microphone capture stream safely...");
      _isActive = false;
      
      // FIXED: Safely invoke the callback closure now that the variable definition is restored
      onSilenceDetected();
    });
  }

  /// Cancels the background timer loop safely to prevent asynchronous memory resource leaks
  void stop() {
    _isActive = false;
    _silenceTimer?.cancel();
    _silenceTimer = null;
  }
}
