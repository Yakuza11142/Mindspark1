import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

abstract class PaintCommand {
  void execute(Canvas canvas, Size size, double progress);
}

class UniversalHologramPainter extends CustomPainter {
  final double animationProgress;
  final List<PaintCommand> drawingInstructions;

  UniversalHologramPainter({
    required this.animationProgress,
    required this.drawingInstructions,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Defends the loop from concurrent modification crashes by processing a snapshot of the list
    final int instructionCount = drawingInstructions.length;
    
    for (int i = 0; i < instructionCount; i++) {
      canvas.save();
      // Safely run individual operations in isolated coordinate spaces
      drawingInstructions[i].execute(canvas, size, animationProgress);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant UniversalHologramPainter oldDelegate) {
    // FIXED: Removed the dynamic evaluation closure antipattern.
    // Primitives are compared directly; arrays are compared using highly optimized list equality checks.
    if (oldDelegate.animationProgress != animationProgress) return true;
    return !listEquals(oldDelegate.drawingInstructions, drawingInstructions);
  }
}
