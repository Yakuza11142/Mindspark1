import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class NativeCamera {
  static const _channel = MethodChannel('com.mindspark.app/camera');

  static Future<void> startCameraPreview() async {
    await _channel.invokeMethod('startPreview');
  }

  static Future<String?> capturePhoto() async {
    return await _channel.invokeMethod<String>('capturePhoto');
  }
}
