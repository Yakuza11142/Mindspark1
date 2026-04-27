import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PulseButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;

  const PulseButton({super.key, required this.onTap, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: color.withOpacity(0.6), blurRadius: 15)]
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05)),
    );
  }
}