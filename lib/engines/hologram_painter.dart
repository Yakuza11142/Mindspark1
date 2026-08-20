import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

/// Command interface updated with Floating-Origin & Log Scale Factor
abstract class PaintCommand {
  void execute({
    required Canvas canvas,
    required Size size,
    required double progress,
    required Offset originOffset, // Local floating origin shift
    required double logScale,     // Infinite scale multiplier
  });
}

class UniversalHologramPainter extends CustomPainter {
  final double animationProgress;
  final List<PaintCommand> drawingInstructions;

  /// Floating Origin Shift (Normalized local center offset)
  final Offset originOffset;

  /// Infinite Scale Exponent Factor (e.g., math.pow(10, exponent))
  final double logScaleExponent;

  UniversalHologramPainter({
    required this.animationProgress,
    required this.drawingInstructions,
    this.originOffset = Offset.zero,
    this.logScaleExponent = 0.0,
  });

  /// Computes safe logarithmic scale multiplier for vector operations
  double get effectiveScale => math.pow(10.0, logScaleExponent).toDouble();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final int instructionCount = drawingInstructions.length;
    final double scale = effectiveScale;

    for (int i = 0; i < instructionCount; i++) {
      canvas.save();

      // Execute each paint command inside isolated, scale-invariant transform matrix
      drawingInstructions[i].execute(
        canvas: canvas,
        size: size,
        progress: animationProgress,
        originOffset: originOffset,
        logScale: scale,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant UniversalHologramPainter oldDelegate) {
    // Direct scalar comparisons for zero-allocation performance check
    if (oldDelegate.animationProgress != animationProgress) return true;
    if (oldDelegate.logScaleExponent != logScaleExponent) return true;
    if (oldDelegate.originOffset != originOffset) return true;

    // Quick reference check for instruction array mutations
    if (oldDelegate.drawingInstructions.length != drawingInstructions.length) return true;
    return !listEquals(oldDelegate.drawingInstructions, drawingInstructions);
  }
}