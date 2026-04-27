import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TypewriterText extends StatelessWidget {
  final String text;
  final TextStyle style;
  const TypewriterText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    // Splits text and animates each character
    // For performance on long text, we simply animate the block fade-in
    return Text(text, style: style)
        .animate()
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.1, end: 0);
  }
}