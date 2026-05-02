import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BreathingGlowEffect extends StatelessWidget {
  final Widget child;
  const BreathingGlowEffect({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child.animate(onPlay: (c) => c.repeat(reverse: true))
        .boxShadow(begin: const BoxShadow(color: Colors.transparent), end: BoxShadow(color: Colors.cyanAccent.withOpacity(0.5), blurRadius: 20));
  }
}