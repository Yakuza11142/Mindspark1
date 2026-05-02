import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BouncingLogo extends StatelessWidget {
  const BouncingLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.bolt, size: 100, color: Colors.cyanAccent)
        .animate(onPlay: (c) => c.repeat(reverse: true)).scaleXY(end: 1.1, duration: 1.seconds);
  }
}