import 'package:flutter/material.dart';

class MicGainVisualizer extends StatelessWidget {
  final double audioLevel; // Passed from SpeechToText soundLevel stream
  const MicGainVisualizer({super.key, required this.audioLevel});

  @override
  Widget build(BuildContext context) {
    double size = 50 + (audioLevel * 5); // Base size 50, expands with voice volume
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.cyanAccent.withOpacity(0.5),
        boxShadow:[BoxShadow(color: Colors.cyan, blurRadius: audioLevel * 2)]
      ),
      child: const Icon(Icons.mic, color: Colors.black),
    );
  }
}