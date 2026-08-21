import 'package:flutter/services.dart';

class NativeSecurity {
  static const _channel = MethodChannel('com.mindspark.app/security');

  static Future<void> secureScreen() async {
    await _channel.invokeMethod('enableSecureWindow');
  }

  static Future<bool> isDeviceRooted() async {
    return await _channel.invokeMethod<bool>('checkRoot') ?? false;
  }
}
