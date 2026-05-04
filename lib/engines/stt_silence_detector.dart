import 'dart:async';

class SttSilenceDetector {
  Timer? _silenceTimer;
  final VoidCallback onSilenceDetected;

  SttSilenceDetector(this.onSilenceDetected);

  void resetTimer() {
    _silenceTimer?.cancel();
    _silenceTimer = Timer(const Duration(milliseconds: 1500), () {
      print("Silence detected. Closing microphone stream...");
      onSilenceDetected();
    });
  }

  void stop() => _silenceTimer?.cancel();
}