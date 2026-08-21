import 'package:flutter/services.dart';

class NativeNetwork {
  static const _channel = MethodChannel('com.mindspark.app/network');

  static Future<bool> isConnected() async {
    return await _channel.invokeMethod<bool>('checkConnection') ?? false;
  }
}
