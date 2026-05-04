import 'package:flutter/services.dart';

class AudioNoiseSuppressor {
  static const MethodChannel _channel = MethodChannel('mindspark/audio_config');

  static Future<void> enableHardwareNoiseCancellation() async {
    try {
      // Calls native Android AudioManager to enable AcousticEchoCanceler and NoiseSuppressor
      await _channel.invokeMethod('enableNoiseSuppression');
      print("🎙️ Hardware Noise Suppression: ACTIVE.");
    } catch (e) {
      print("Noise Suppression not supported on this hardware.");
    }
  }
}