import 'package:flutter/material.dart';

class InteractivePeriodicTableLite extends StatelessWidget {
  const InteractivePeriodicTableLite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.black87,
      child: const Text("H (1), He (2), Li (3), Be (4)...", style: TextStyle(color: Colors.cyanAccent, fontFamily: 'monospace')),
    );
  }
}