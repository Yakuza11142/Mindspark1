import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BreathingGlowEffect extends StatelessWidget {
  final Widget child;
  const BreathingGlowEffect({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (controller) => controller.repeat(reverse: true),
      child: child,
    )
    .boxShadow(
      begin: const BoxShadow(
        color: Colors.transparent, 
        blurRadius: 0,
      ),
      end: BoxShadow(
        color: Colors.cyanAccent.withValues(alpha: 0.5), 
        blurRadius: 25,
        spreadRadius: 2,
      ),
      duration: 2.seconds, 
      curve: Curves.easeInOut, 
    );
  }
}
