import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TypingIndicatorDots extends StatelessWidget {
  const TypingIndicatorDots({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (i) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        width: 8, height: 8,
        decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
      ).animate(onPlay: (c) => c.repeat()).fade(duration: 600.ms, delay: Duration(milliseconds: i * 200))),
    );
  }
}