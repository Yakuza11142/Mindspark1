import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PulseRing extends StatelessWidget {
  const PulseRing({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, height: 100,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.cyanAccent, width: 2)),
    ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(0.8, 0.8), end: const Offset(1.5, 1.5)).fadeOut();
  }
}