import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MathStreakWidget extends StatelessWidget {
  final int streakCount;
  const MathStreakWidget({super.key, required this.streakCount});

  @override
  Widget build(BuildContext context) {
    if (streakCount < 3) return const SizedBox.shrink();
    return Text(
      "${streakCount}x COMBO! 🔥", 
      style: const TextStyle(fontSize: 24, color: Colors.orange, fontWeight: FontWeight.bold)
    ).animate().scale(duration: 200.ms).then().shake();
  }
}