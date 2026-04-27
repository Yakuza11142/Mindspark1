import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatelessWidget {
  final Widget child;
  const AnimatedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: const Color(0xFF0F172A)),
        Positioned(
          top: -100, left: -100,
          child: Container(width: 300, height: 300, decoration: const BoxDecoration(color: Colors.purple, shape: BoxShape.circle)).animate().blur(begin: const Offset(50,50), end: const Offset(50,50)),
        ),
        child
      ],
    );
  }
}