import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HologramGlitchLoader extends StatelessWidget {
  final Widget child;
  const HologramGlitchLoader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(duration: 500.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white70)
        .shake(hz: 4, curve: Curves.easeInOut) // The "Digital Flicker"
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}
