import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DynamicButtonGlow extends StatelessWidget {
  final VoidCallback onTap;
  const DynamicButtonGlow({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow:[BoxShadow(color: Colors.cyanAccent.withOpacity(0.5), blurRadius: 20, spreadRadius: 5)],
        borderRadius: BorderRadius.circular(30)
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.black, side: const BorderSide(color: Colors.cyanAccent)),
        child: const Text("START JAMB MOCK", style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
      ),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.05);
  }
}