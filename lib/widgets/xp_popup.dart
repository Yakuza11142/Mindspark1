import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class XpPopup extends StatelessWidget {
  final int amount;
  const XpPopup({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "+$amount XP",
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.amber,
          shadows: [
            Shadow(blurRadius: 10, color: Colors.orange),
          ],
        ),
      )
          .animate()
          .moveY(begin: 0, end: -100, duration: 1000.ms)
          .fadeOut()
          // CRUCIAL: Completely removes the widget structure from screen memory paths when opacity hits 0
          .visibility(maintainState: false),
    );
  }
}
