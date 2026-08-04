import 'package:flutter/material.dart';

class SiriGlowOrb extends StatelessWidget {
  final bool isListening;
  final Color color;

  const SiriGlowOrb({super.key, required this.isListening, required this.color});

  @override
  Widget build(BuildContext context) {
    // FIXED: Formed type-safe conditional array parameters to resolve the missing token crash
    final List<BoxShadow> activeGlow = isListening 
        ? [BoxShadow(color: color.withValues(alpha: 0.6), blurRadius: 40, spreadRadius: 10)] 
        : const [];

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: 150, 
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
        boxShadow: activeGlow,
        border: Border.all(
          color: isListening ? color : Colors.grey.shade800,
          width: 2,
        ),
      ),
      child: Icon(
        isListening ? Icons.graphic_eq : Icons.mic,
        color: isListening ? color : Colors.grey,
        size: 40,
      ),
    );
  }
}
