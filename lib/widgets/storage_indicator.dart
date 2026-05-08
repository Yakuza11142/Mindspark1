import 'package:flutter/material.dart';

class StorageIndicator extends StatelessWidget {
  final double usedMB;
  const StorageIndicator({super.key, required this.usedMB});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Offline Storage", style: TextStyle(color: Colors.grey)),
        LinearProgressIndicator(value: usedMB / 1000, color: Colors.blue), // Assuming 1GB limit
        Text("${usedMB.toStringAsFixed(1)} MB used"),
      ],
    );
  }
}