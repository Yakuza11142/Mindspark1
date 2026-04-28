import 'package:flutter/material.dart';
class TimeoutRecoveryUi extends StatelessWidget {
  const TimeoutRecoveryUi({super.key});
  @override
  Widget build(BuildContext context) => const Text("Network overloaded. Please tap 'Send' again.", style: TextStyle(color: Colors.orange));
}