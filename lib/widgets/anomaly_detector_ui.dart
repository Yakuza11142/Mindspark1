import 'package:flutter/material.dart';
class AnomalyDetectorUi extends StatelessWidget {
  const AnomalyDetectorUi({super.key});
  @override
  Widget build(BuildContext context) => const Scaffold(backgroundColor: Colors.red, body: Center(child: Text("GEO-ANOMALY DETECTED. PLEASE DISABLE VPN.", style: TextStyle(color: Colors.white, fontSize: 18))));
}