import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
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

class _QuantumNexusVectorState extends State<QuantumNexusVector> with SingleTickerProviderStateMixin {
  late v64.Matrix4 _projectionModelMatrix;
  Timer? _matrixProcessingLoop;
  double _frequencyTimer = 0.0;
  
  // Enforce base anatomical proportions natively
  static const double _baseHologramHeightFeet = 6.0;
  static const double _minLimitFeet = 0.125; // 1.5 inches
  static const double _maxLimitFeet = 10.0;  // 10 feet

  double _currentScaleFactor = 1.0;
  double _verticalAnchorShift = 0.0;

  @override
  void initState() {
    super.initState();
    _initQuantumNexusPipeline();
  }

  void _initQuantumNexusPipeline() {
    _projectionModelMatrix = v64.Matrix4.identity();
    _calculateProportionalScaling();

    // 120Hz computational projection matrix update loop
    _matrixProcessingLoop = Timer.periodic(const Duration(microseconds: 8333), (timer) {
      if (!mounted) return;
      _computeMatrixTransformations();
    });
  }

  @override
  void didUpdateWidget(covariant QuantumNexusVector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.requestedHeightFeet != widget.requestedHeightFeet) {
      _calculateProportionalScaling();
    }
  }

  void _calculateProportionalScaling() {
    final double clampedInput = widget.requestedHeightFeet.clamp(_minLimitFeet, _maxLimitFeet);
    
    // Calculate local space scale factor relative to the 6ft base blueprint
    final double targetScaleFactor = _baseHologramHeightFeet / clampedInput;
    
    // Calculate vertical alignment shift to keep his feet locked to the floor
    final double targetVerticalShift = 0.5 * (1.0 - (1.0 / targetScaleFactor));

    setState(() {
      _currentScaleFactor = targetScaleFactor;
      _verticalAnchorShift = targetVerticalShift;
    });
  }

  void _computeMatrixTransformations() {
    setState(() {
      _frequencyTimer += 0.008333;

      // Procedural harmonic oscillation simulates human life breathing mechanics
      final double breathSwayY = math.sin(_frequencyTimer * 2.4) * 0.015;
      final double microTremorX = math.cos(_frequencyTimer * 4.1) * 0.004;

      _projectionModelMatrix = v64.Matrix4.identity()
        ..translate(microTremorX, breathSwayY, -0.85)
        ..rotateY(math.sin(_frequencyTimer * 0.5) * 0.02);
    });
  }

  @override
  void dispose() {
    _matrixProcessingLoop?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size sceneViewportSize = Size(constraints.maxWidth, constraints.maxHeight);

        return InheritedSparkScale(
          scaleFactor: _currentScaleFactor,
          verticalShift: _verticalAnchorShift,
          timelineDelta: _frequencyTimer,
          viewportDimensions: sceneViewportSize,
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

  const InheritedSparkScale({
    super.key,
    required this.scaleFactor,
    required this.verticalShift,
    required this.timelineDelta,
    required this.viewportDimensions,
    required super.child,
  });

  static InheritedSparkScale? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedSparkScale>();
  }

  @override
  bool updateShouldNotify(InheritedSparkScale oldWidget) {
    return oldWidget.scaleFactor != scaleFactor || 
           oldWidget.verticalShift != verticalShift ||
           oldWidget.timelineDelta != timelineDelta;
  }
}
