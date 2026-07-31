import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vector_math/vector_math_64.dart' as v64;

class QuantumNexusVector extends StatefulWidget {
  final Widget child; // Wraps your AetherCore Pro Hologram view
  final double requestedHeightFeet; // Runtime dynamic size input (1.5" to 10ft)

  const QuantumNexusVector({
    super.key,
    required this.child,
    required this.requestedHeightFeet,
  });

  @override
  State<QuantumNexusVector> createState() => _QuantumNexusVectorState();
}

class _QuantumNexusVectorState extends State<QuantumNexusVector>
    with SingleTickerProviderStateMixin {
  late v64.Matrix4 _projectionModelMatrix;
  Ticker? _frameTicker;
  double _frequencyTimer = 0.0;

  static const double _baseHologramHeightFeet = 6.0;
  static const double _minLimitFeet = 0.125; // 1.5 inches
  static const double _maxLimitFeet = 10.0;  // 10 feet

  double _currentScaleFactor = 1.0;
  double _verticalAnchorShift = 0.0;

  @override
  void initState() {
    super.initState();
    _projectionModelMatrix = v64.Matrix4.identity();
    _calculateProportionalScaling();

    // FIXED: Swapped out the processor-burning Timer loop for a native, hardware-synchronized Ticker
    _frameTicker = createTicker((Duration elapsed) {
      if (!mounted) return;
      _computeMatrixTransformations(elapsed);
    });
    _frameTicker!.start();
  }

  @override
  void didUpdateWidget(covariant QuantumNexusVector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.requestedHeightFeet != widget.requestedHeightFeet) {
      _calculateProportionalScaling();
    }
  }

  void _calculateProportionalScaling() {
    final double clampedInput =
        widget.requestedHeightFeet.clamp(_minLimitFeet, _maxLimitFeet);

    // FIXED: Corrected inverted scale mathematics so assets shrink and grow properly
    final double targetScaleFactor = clampedInput / _baseHologramHeightFeet;

    // FIXED: Adjust dynamic vertical anchoring parameters relative to correct tracking scales
    final double targetVerticalShift = 0.5 * (1.0 - targetScaleFactor);

    setState(() {
      _currentScaleFactor = targetScaleFactor;
      _verticalAnchorShift = targetVerticalShift;
    });
  }

  void _computeMatrixTransformations(Duration elapsed) {
    setState(() {
      // Safely fetch continuous delta ticks from frame execution times
      _frequencyTimer = elapsed.inMicroseconds / Duration.microsecondsPerSecond;

      final double breathSwayY = math.sin(_frequencyTimer * 2.4) * 0.015;
      final double microTremorX = math.cos(_frequencyTimer * 4.1) * 0.004;

      _projectionModelMatrix = v64.Matrix4.identity()
        ..translate(microTremorX, breathSwayY, -0.85)
        ..rotateY(math.sin(_frequencyTimer * 0.5) * 0.02);
    });
  }

  @override
  void dispose() {
    _frameTicker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size sceneViewportSize =
            Size(constraints.maxWidth, constraints.maxHeight);

        return InheritedSparkScale(
          scaleFactor: _currentScaleFactor,
          verticalShift: _verticalAnchorShift,
          timelineDelta: _frequencyTimer,
          viewportDimensions: sceneViewportSize,
          projectionMatrix: _projectionModelMatrix, // FIXED: Expose the computed transformation data downstream
          child: SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: widget.child,
          ),
        );
      },
    );
  }
}

class InheritedSparkScale extends InheritedWidget {
  final double scaleFactor;
  final double verticalShift;
  final double timelineDelta;
  final Size viewportDimensions;
  final v64.Matrix4 projectionMatrix;

  const InheritedSparkScale({
    super.key,
    required this.scaleFactor,
    required this.verticalShift,
    required this.timelineDelta,
    required this.viewportDimensions,
    required this.projectionMatrix,
    required super.child,
  });

  static InheritedSparkScale? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSparkScale>();
  }

  @override
  bool updateShouldNotify(InheritedSparkScale oldWidget) {
    return oldWidget.scaleFactor != scaleFactor ||
        oldWidget.verticalShift != verticalShift ||
        oldWidget.timelineDelta != timelineDelta ||
        oldWidget.projectionMatrix != projectionMatrix;
  }
}
