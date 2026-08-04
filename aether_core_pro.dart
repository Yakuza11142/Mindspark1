import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v64;
import 'quantum_nexus_vector.dart';

class AetherCoreProHologram extends StatelessWidget {
  const AetherCoreProHologram({super.key});

  @override
  Widget build(BuildContext context) {
    final InheritedSparkScale? sparkData = InheritedSparkScale.of(context);
    
    if (sparkData == null) {
      return const Center(child: Text("Error: Missing QuantumNexusVector Context"));
    }

    return RepaintBoundary(
      child: CustomPaint(
        size: sparkData.viewportDimensions,
        painter: HolographicMeshPainter(
          matrix: sparkData.projectionMatrix,
          scale: sparkData.scaleFactor,
          shiftY: sparkData.verticalShift,
          time: sparkData.timelineDelta,
        ),
      ),
    );
  }
}

class HolographicMeshPainter extends CustomPainter {
  final v64.Matrix4 matrix;
  final double scale;
  final double shiftY;
  final double time;

  HolographicMeshPainter({
    required this.matrix,
    required this.scale,
    required this.shiftY,
    required this.time,
  });

  final List<v64.Vector3> _skeletalVertices = [
    v64.Vector3(0.0, 1.83, 0.0),   
    v64.Vector3(0.45, 0.95, 0.2),  
    v64.Vector3(-0.45, 0.95, -0.2), 
    v64.Vector3(0.0, 0.0, 0.0),    
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // FIXED: Swapped out deprecated withOpacity method for modern withValues alpha layers
    final Paint neonAuraBrush = Paint()
      ..color = const Color(0xFF00F3FF).withValues(alpha: 0.35 + (Offset(scale, shiftY).distance % 0.15)) 
      ..strokeWidth = 14.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    final Paint coreLaserBrush = Paint()
      ..color = const Color(0xFFE6FFFF)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // FIXED: Swapped out deprecated scale method for type-safe scaleByDouble adjustments
    final v64.Matrix4 localViewportTransform = v64.Matrix4.identity()
      ..translateByDouble(size.width / 2, size.height * (0.8 + shiftY), 0.0, 1.0) 
      ..scaleByDouble(120.0 * scale, -120.0 * scale, 1.0); 

    final v64.Matrix4 absoluteTransformationMatrix = localViewportTransform * matrix;

    List<Offset> projectedNodes = [];
    for (var position3d in _skeletalVertices) {
      final v64.Vector3 compiledVector = absoluteTransformationMatrix.transform3(v64.Vector3.copy(position3d));
      projectedNodes.add(Offset(compiledVector.x, compiledVector.y));
    }

    if (projectedNodes.length >= 4) {
      final Path structurePath = Path()
        ..moveTo(projectedNodes[3].dx, projectedNodes[3].dy) 
        ..lineTo(projectedNodes[2].dx, projectedNodes[2].dy) 
        ..lineTo(projectedNodes[0].dx, projectedNodes[0].dy) 
        ..lineTo(projectedNodes[1].dx, projectedNodes[1].dy) 
        ..close();

      canvas.drawPath(structurePath, neonAuraBrush);
      canvas.drawPath(structurePath, coreLaserBrush);
      
      final Paint nodeBrush = Paint()..color = Colors.white;
      for (var node in projectedNodes) {
        canvas.drawCircle(node, 5.0, nodeBrush);
      }
    }
  }

  @override
  bool shouldRepaint(covariant HolographicMeshPainter oldDelegate) {
    return oldDelegate.matrix != matrix || oldDelegate.time != time;
  }
}
