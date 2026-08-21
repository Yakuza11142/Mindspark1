import 'package:flutter/services.dart';

class DeviceHardware {
  static const _channel = MethodChannel('com.yakuza111.app/hardware');

  static Future<int> getBatteryLevel() async {
    return await _channel.invokeMethod<int>('getBatteryLevel') ?? -1;
  }

  static Future<void> launchUrl(String url) async {
    await _channel.invokeMethod('launchUrl', {'url': url});
  }
}
