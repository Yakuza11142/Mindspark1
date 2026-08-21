import 'package:flutter/services.dart';

class NativeFeedback {
  static const _channel = MethodChannel('com.mindspark.app/feedback');

  static Future<void> triggerVibration() async {
    await _channel.invokeMethod('vibrate');
  }

  static Future<void> setBrightness(double value) async {
    await _channel.invokeMethod('setBrightness', {'level': value});
  }
}
