import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ExclusiveProBadge extends StatelessWidget {
  const ExclusiveProBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors:[Colors.amber, Colors.orange]),
        borderRadius: BorderRadius.circular(4),
        boxShadow:[BoxShadow(color: Colors.amber.withOpacity(0.5), blurRadius: 5)]
      ),
      child: const Text("PRO", style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
    ).animate(onPlay: (c) => c.repeat(reverse: true)).shimmer(duration: 2.seconds, color: Colors.white);
  }
}