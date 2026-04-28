import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SiriGlowOrb extends StatelessWidget {
  final bool isListening;
  final Color color;

  const SiriGlowOrb({super.key, required this.isListening, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        boxShadow: isListening ?[BoxShadow(color: color.withOpacity(0.6), blurRadius: 40, spreadRadius: 10)] :