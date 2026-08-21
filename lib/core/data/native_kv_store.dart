import 'package:flutter/services.dart';

class NativeKvStore {
  static const _channel = MethodChannel('com.mindspark.app/kv_store');

  static Future<void> write(String key, String value) async {
    await _channel.invokeMethod('write', {'key': key, 'value': value});
  }

  static Future<String?> read(String key) async {
    return await _channel.invokeMethod<String>('read', {'key': key});
  }
}
