import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class VirtualTutorAvatar extends StatelessWidget {
  final bool isSpeaking;
  const VirtualTutorAvatar({super.key, required this.isSpeaking});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(colors: [Colors.cyanAccent, Colors.blue]),
        boxShadow: isSpeaking ?[BoxShadow(color: Colors.cyanAccent.withOpacity(0.8), blurRadius: 30, spreadRadius: 10)] :[],
      ),
      child: const Icon(Icons.auto_awesome, size: 50, color: Colors.black),
    ).animate(target: isSpeaking ? 1 : 0).scale(begin: const Offset(1,1), end: const Offset(1.1, 1.1));
  }
}