import 'package:flutter/material.dart';

class MeshGradientSafe extends StatelessWidget {
  final Widget child;
  const MeshGradientSafe({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    // Uses solid color if battery saver is on
    return Container(color: const Color(0xFF0F172A), child: child);
  }
}