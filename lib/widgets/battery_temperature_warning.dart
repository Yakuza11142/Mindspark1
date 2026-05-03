import 'package:flutter/material.dart';
class BatteryTemperatureWarning extends StatelessWidget {
  const BatteryTemperatureWarning({super.key});
  @override
  Widget build(BuildContext context) {
    return const Tooltip(message: "Device Temp: 35°C (Optimal)", child: Icon(Icons.thermostat, color: Colors.green, size: 16));
  }
}