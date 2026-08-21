import 'package:flutter/services.dart';

class NativeSensors {
  static const _eventChannel = EventChannel('com.mindspark.app/sensor_stream');

  Stream<List<double>> get sensorData {
    return _eventChannel.receiveBroadcastStream().map((dynamic event) {
      final List<dynamic> list = event as List<dynamic>;
      return list.map((e) => e as double).toList();
    });
  }
}
