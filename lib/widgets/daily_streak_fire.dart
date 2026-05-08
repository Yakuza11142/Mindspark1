import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DailyStreakFire extends StatelessWidget {
  final int days;
  const DailyStreakFire({super.key, required this.days});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.local_fire_department, color: Colors.orange, size: 40)
            .animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.2,1.2)),
        Text("$days Days", style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold))
      ],
    );
  }
}