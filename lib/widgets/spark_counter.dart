import 'package:flutter/material.dart';

class SparkCounter extends StatelessWidget {
  final int count;
  const SparkCounter({super.key, required this.count});
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.bolt, color: Colors.amber),
      label: Text("$count", style: const TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: Colors.black54,
    );
  }
}