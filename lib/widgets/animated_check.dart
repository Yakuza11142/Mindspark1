import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedCheck extends StatelessWidget {
  const AnimatedCheck({super.key});
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.check_circle, color: Colors.green, size: 80)
        .animate().scale(duration: 400.ms, curve: Curves.elasticOut);
  }
}