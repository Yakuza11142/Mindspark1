import 'package:flutter/services.dart';

class NativeAudio {
  static const _channel = MethodChannel('com.mindspark.app/audio');

  static Future<void> playSound(String assetPath) async {
    await _channel.invokeMethod('play', {'path': assetPath});
  }

  static Future<void> speakText(String text) async {
    await _channel.invokeMethod('speak', {'text': text});
  }
}
