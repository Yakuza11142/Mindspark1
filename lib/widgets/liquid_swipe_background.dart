import 'package:flutter/material.dart';

class LiquidSwipeBackground extends StatelessWidget {
  final Widget child;
  const LiquidSwipeBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Wraps the screen in a smooth container that simulates liquid transition
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors:[Color(0xFF0F172A), Color(0xFF000000)], begin: Alignment.topCenter, end: Alignment.bottomCenter)
      ),
      child: child,
    );
  }
}