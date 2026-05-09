import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StreakFlame extends StatelessWidget {
  final int days;
  const StreakFlame({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.local_fire_department, color: Colors.orange)
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
        Text("$days", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
      ],
    );
  }
}