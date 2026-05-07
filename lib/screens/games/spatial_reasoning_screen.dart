import 'package:flutter/material.dart';

class SpatialReasoningScreen extends StatelessWidget {
  const SpatialReasoningScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spatial IQ")),
      body: const Center(child: Text("Which 3D shape does this 2D net form?", style: TextStyle(fontSize: 20))),
    );
  }
}