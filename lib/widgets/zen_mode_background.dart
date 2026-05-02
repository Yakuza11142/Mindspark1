import 'package:flutter/material.dart';

class ZenModeBackground extends StatelessWidget {
  final Widget child;
  const ZenModeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors:[Color(0xFF0F172A), Color(0xFF000000)], // Calm, dark, premium
        ),
      ),
      child: child,
    );
  }
}