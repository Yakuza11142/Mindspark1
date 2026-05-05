import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StageHologramScanner extends StatelessWidget {
  const StageHologramScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.cyanAccent,
        boxShadow:[BoxShadow(color: Colors.cyanAccent.withOpacity(0.8), blurRadius: 10, spreadRadius: 5)]
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: 300, duration: 1.5.seconds);
  }
}