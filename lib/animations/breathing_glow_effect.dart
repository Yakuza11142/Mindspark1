import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BreathingGlowEffect extends StatelessWidget {
  final Widget child;
  const BreathingGlowEffect({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // FIXED: Ensured the animate sequence is attached safely to a layout block
    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      child: child,
    )
    // FIXED: Added the mandatory duration parameter to ensure compilation passes
    .boxShadow(
      begin: const BoxShadow(
        color: Colors.transparent, 
        blurRadius: 0,
      ),
      end: BoxShadow(
        // Note: Using standard opacity mapping for uniform framework version support
        color: Colors.cyanAccent.withOpacity(0.5), 
        blurRadius: 25,
        spreadRadius: 2,
      ),
      duration: 2.seconds, // Defines the baseline breathing cycle length
      curve: Curves.easeInOut, // Smooths out the peak transitions of the breath loop
    );
  }
}
