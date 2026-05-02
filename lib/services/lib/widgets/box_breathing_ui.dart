import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BoxBreathingUi extends StatelessWidget {
  const BoxBreathingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Text("Clear your mind.", style: TextStyle(color: Colors.cyanAccent, fontSize: 24, decoration: TextDecoration.none)),
            const SizedBox(height: 40),
            Container(
              width: 150, height: 150,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.cyanAccent, width: 4)),
            ).animate(onPlay: (c) => c.repeat(reverse: true))
             .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.5, 1.5), duration: 4.seconds, curve: Curves.easeInOutSine),
            const SizedBox(height: 40),
            const Text("Breathe In (4s) • Hold (4s) • Breathe Out (4s)", style: TextStyle(color: Colors.white54, fontSize: 16, decoration: TextDecoration.none)),
          ],
        ),
      ),
    );
  }
}