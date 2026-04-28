import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HologramVfxOverlay extends StatelessWidget {
  const HologramVfxOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, height: 5,
      color: Colors.cyanAccent.withOpacity(0.5),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: 0, end: 800, duration: 2.seconds);
  }
}