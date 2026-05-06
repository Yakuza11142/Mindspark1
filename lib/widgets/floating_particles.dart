import 'package:flutter/material.dart';
import 'dart:math';

class FloatingParticles extends StatelessWidget {
  const FloatingParticles({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _ParticlePainter(),
        size: Size.infinite,
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.05);
    final rand = Random(42); // Fixed seed to prevent constant redrawing (saves RAM)
    for (int i = 0; i < 30; i++) {
      canvas.drawCircle(Offset(rand.nextDouble() * size.width, rand.nextDouble() * size.height), rand.nextDouble() * 3, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}