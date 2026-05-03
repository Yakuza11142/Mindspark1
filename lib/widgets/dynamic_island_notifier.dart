import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DynamicIslandNotifier extends StatelessWidget {
  final String message;
  const DynamicIslandNotifier({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.cyan)),
          child: Text(message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ).animate().slideY(begin: -2, end: 0, duration: 400.ms).then(delay: 3.seconds).fadeOut(),
      ),
    );
  }
}