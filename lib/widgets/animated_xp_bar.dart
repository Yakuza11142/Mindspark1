import 'package:flutter/material.dart';

class AnimatedXpBar extends StatelessWidget {
  final double currentXpPercent;
  const AnimatedXpBar({super.key, required this.currentXpPercent});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: currentXpPercent),
      duration: const Duration(seconds: 1),
      builder: (context, value, _) => LinearProgressIndicator(
        value: value,
        color: Colors.cyanAccent,
        backgroundColor: Colors.grey[800],
        minHeight: 12,
      ),
    );
  }
}