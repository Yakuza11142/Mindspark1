import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v64;

// Abstract blueprint handling fluid, non-hardcoded interactive objects
abstract class SpatialInteractiveObject {
  String get uniqueId;
  Widget buildEntityVisual(BuildContext context, Size renderBoundary);
}

class QuantumNexusVector extends StatefulWidget {
  final Widget child; // Wraps AetherCore Pro Hologram View
  final SpatialInteractiveObject? activeObject; // Nullable dynamic object stream
  final v64.Vector3 targetHandOffset; // Runtime skeletal attachment matrix

  const QuantumNexusVector({
    super.key,
    required this.child,
    this.activeObject,
    v64.Vector3? targetHandOffset,
  }) : targetHandOffset = targetHandOffset ?? const v64.Vector3.zero();

  @override
  State<QuantumNexusVector> createState() => _QuantumNexusVectorState();
}

class _QuantumNexusVectorState extends State<QuantumNexusVector> {
  late v64.Vector3 _skeletalAnchorPoint;
  late v64.Matrix4 _projectionModelMatrix;
  Timer? _matrixProcessingLoop;
  double _frequencyTimer = 0.0;

  @override
  void initState() {
    super.initState();
    _initQuantumNexusPipeline();
  }

  void _initQuantumNexusPipeline() {
    // 1. Establish the base 3D coordinate vectors for a 6ft humanoid model
    _skeletalAnchorPoint = v64.Vector3(widget.targetHandOffset.x == 0.0 ? 0.25 : widget.targetHandOffset.x, 
                                      widget.targetHandOffset.y == 0.0 ? 0.15 : widget.targetHandOffset.y, 
                                      widget.targetHandOffset.z == 0.0 ? -0.85 : widget.targetHandOffset.z);
    _projectionModelMatrix = v64.Matrix4.identity();

    // 2. High-Frequency 120Hz computational projection matrix updater loop
    _matrixProcessingLoop = Timer.periodic(const Duration(microseconds: 8333), (timer) {
      if (!mounted) return;
      _computeMatrixTransformations();
    });
  }

  void _computeMatrixTransformations() {
    setState(() {
      _frequencyTimer += 0.008333;

      // 3. Procedural harmonic oscillation simulates human life breathing mechanics
      final double breathSwayY = math.sin(_frequencyTimer * 2.4) * 0.015;
      final double microTremorX = math.cos(_frequencyTimer * 4.1) * 0.004;

      // 4. Transform native joint vectors dynamically based on micro-movement tracking
      _projectionModelMatrix = v64.Matrix4.identity()
        ..translate(_skeletalAnchorPoint.x + microTremorX, 
                    _skeletalAnchorPoint.y + breathSwayY, 
                    _skeletalAnchorPoint.z)
        ..rotateY(math.sin(_frequencyTimer * 0.5) * 0.02); // Simulates body rotational drift
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
        // 5. Extract global boundary dimensions instantly—zero hardcoded dimensions
        final Size sceneViewportSize = Size(constraints.maxWidth, constraints.maxHeight);

        // 6. Project local joint coordinates into absolute coordinate spaces
        final v64.Vector3 absoluteScreenCoordinates = _projectionModelMatrix.translation();

        // 7. Map normalized vector coordinates securely onto target display pixel grids
        final double calculatedLeftPosition = (sceneViewportSize.width / 2) + (absoluteScreenCoordinates.x * (sceneViewportSize.width / 2));
        final double calculatedTopPosition = (sceneViewportSize.height / 2) - (absoluteScreenCoordinates.y * (sceneViewportSize.height / 2));

        return Stack(
          children: [
            // Structural Client-Streaming Substrate Layer
            Positioned.fill(child: widget.child),

            // Responsive Object Snapping Core Layer
            if (widget.activeObject != null)
              Positioned(
                left: calculatedLeftPosition,
                top: calculatedTopPosition,
                child: FractionalTranslation(
                  translation: const Offset(-0.5, -0.5), // Forces true mathematical centroid alignment
                  child: Listener(
                    onPointerMove: (PointerMoveEvent event) {
                      // 8. Transform dynamic screen gestures smoothly back into raw space
                      setState(() {
                        _skeletalAnchorPoint.x += event.delta.dx / (sceneViewportSize.width / 2);
                        _skeletalAnchorPoint.y -= event.delta.dy / (sceneViewportSize.height / 2);
                      });
                    },
                    child: widget.activeObject!.buildEntityVisual(context, sceneViewportSize),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
