import 'package:flutter/material.dart';

abstract class PaintCommand {
  void execute(Canvas canvas, Size size, double progress);
}

class UniversalHologramPainter extends CustomPainter {
  final double animationProgress;
  final List<PaintCommand> drawingInstructions;
  final bool Function(double, double, List<PaintCommand>, List<PaintCommand>) repaintEvaluation;

  UniversalHologramPainter({
    required this.animationProgress,
    required this.drawingInstructions,
    required this.repaintEvaluation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final instruction in drawingInstructions) {
      instruction.execute(canvas, size, animationProgress);
    }
  }

  @override
  bool shouldRepaint(covariant UniversalHologramPainter oldDelegate) {
    return repaintEvaluation(
      oldDelegate.animationProgress,
      animationProgress,
      oldDelegate.drawingInstructions,
      drawingInstructions,
    );
  }
}
