import 'package:flutter/material.dart';

class BatteryTemperatureUi extends StatelessWidget {
  const BatteryTemperatureUi({super.key});
  @override
  Widget build(BuildContext context) {
    return const Tooltip(message: "System Temp: 32°C", child: Icon(Icons.thermostat, color: Colors.greenAccent, size: 14));
  }
}