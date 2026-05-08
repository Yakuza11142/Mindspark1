import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TypewriterTitle extends StatelessWidget {
  final String text;
  const TypewriterTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Courier'),
    ).animate().typing(duration: 1000.ms);
  }
}