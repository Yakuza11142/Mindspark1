import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v64;
import 'QuantumNexusVector.dart';

class HologramEntityTrack {
  final double x;
  final double y;
  final double scale;
  final double life;

  const HologramEntityTrack({
    required this.x,
    required this.y,
    required this.scale,
    required this.life,
  });

  static const HologramEntityTrack empty = HologramEntityTrack(
    x: 0.0,
    y: 0.0,
    scale: 0.0,
    life: 0.0,
  );
}

class QuantumHologramPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final InheritedSparkScale nexusData;
  final List<HologramEntityTrack> entities;
  
  /// Infinite Scale Exponent: Allows seamless zoom from 10^-9 to 10^9+
  final double logScaleExponent;

  QuantumHologramPainter({
    required this.shader,
    required this.nexusData,
    this.entities = const [],
    this.logScaleExponent = 0.0, // Default 0.0 = 10^0 = 1.0 (Base scale)
  });

  /// Computes infinite exponential factor safely for the shader pipeline
  double get infiniteScaleFactor {
    // Standard nexus scale multiplied by exponential scale factor
    return nexusData.scaleFactor * math.pow(10.0, logScaleExponent).toDouble();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    // Extract translation vector from matrix
    final v64.Vector3 translation = nexusData.projectionMatrix.getTranslation();

    // 1. REGISTER: uViewportDimensions (vec2)
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    // 2. REGISTER: uTimelineDelta (float)
    shader.setFloat(2, nexusData.timelineDelta);

    // 3. REGISTER: uHologramStats [CentroidX, CentroidY, CoreGlow, LocalScaleFactor] (vec4)
    // FLOATING ORIGIN ADJUSTMENT: Normalize viewport space based on infinite scaling center
    final double centroidX = 0.5 + (translation.x % 1.0); 
    final double centroidY = nexusData.verticalShift + (translation.y % 1.0);
    const double coreGlow = 0.85;

    shader.setFloat(3, centroidX);
    shader.setFloat(4, centroidY);
    shader.setFloat(5, coreGlow);
    // PASS INFINITE LOGARITHMIC SCALE FACTOR DIRECTLY TO GLSL REGISTER
    shader.setFloat(6, infiniteScaleFactor);

    // 4. REGISTER: uHoloSystemFX [ScanSpeed, ScanIntensity, TeleportGlitchTrigger, NoiseDensity] (vec4)
    shader.setFloat(7, 0.35);  // ScanSpeed
    shader.setFloat(8, 0.50);  // ScanIntensity
    shader.setFloat(9, 0.00);  // TeleportGlitchTrigger
    shader.setFloat(10, 0.04); // NoiseDensity

    // 5. UNROLLED DATA MATRIX: uEntity0 through uEntity5 (6 x vec4 = 24 float registers)
    int floatIndex = 11;
    for (int i = 0; i < 6; i++) {
      final track = i < entities.length ? entities[i] : HologramEntityTrack.empty;
      
      // Dynamically re-scale child entities relative to infinite logarithmic factor
      final double dynamicEntityScale = track.scale * (infiniteScaleFactor / nexusData.scaleFactor);

      shader.setFloat(floatIndex++, track.x);
      shader.setFloat(floatIndex++, track.y);
      shader.setFloat(floatIndex++, dynamicEntityScale);
      shader.setFloat(floatIndex++, track.life);
    }

    // Draw full render-pass
    final paint = Paint()..shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant QuantumHologramPainter oldDelegate) {
    return oldDelegate.nexusData.timelineDelta != nexusData.timelineDelta ||
        oldDelegate.nexusData.scaleFactor != nexusData.scaleFactor ||
        oldDelegate.nexusData.projectionMatrix != nexusData.projectionMatrix ||
        oldDelegate.logScaleExponent != logScaleExponent;
  }
}
