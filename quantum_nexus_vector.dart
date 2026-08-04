import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:vector_math/vector_math_64.dart' as v64;

class QuantumNexusVector extends StatefulWidget {
  final Widget child; 
  final double requestedHeightFeet; 

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
  static const double _minLimitFeet = 0.125; 
  static const double _maxLimitFeet = 10.0;  

  double _currentScaleFactor = 1.0;
  double _verticalAnchorShift = 0.0;

  @override
  void initState() {
    super.initState();
    _projectionModelMatrix = v64.Matrix4.identity();
    _calculateProportionalScaling();

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

    final double targetScaleFactor = clampedInput / _baseHologramHeightFeet;
    final double targetVerticalShift = 0.5 * (1.0 - targetScaleFactor);

    setState(() {
      _currentScaleFactor = targetScaleFactor;
      _verticalAnchorShift = targetVerticalShift;
    });
  }

  void _computeMatrixTransformations(Duration elapsed) {
    setState(() {
      _frequencyTimer = elapsed.inMicroseconds / Duration.microsecondsPerSecond;

      final double breathSwayY = math.sin(_frequencyTimer * 2.4) * 0.015;
      final double microTremorX = math.cos(_frequencyTimer * 4.1) * 0.004;

      // FIXED: Passed all 4 spatial dimensions to translateByDouble to prevent compilation crashes
      _projectionModelMatrix = v64.Matrix4.identity()
        ..translateByDouble(microTremorX, breathSwayY, -0.85, 1.0)
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
          projectionMatrix: _projectionModelMatrix, 
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
