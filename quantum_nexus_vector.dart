import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as v64;

// Explicit local reference import to pull your InheritedWidget context parameters cleanly
import 'quantum_nexus_vector.dart'; 

/// The production-grade 3D graphics consumer node designed 
/// to receive your InheritedSparkScale matrix payloads.
class AetherCoreProHologram extends StatelessWidget {
  const AetherCoreProHologram({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Fetch your high-speed matrix transformation constants from the parent node
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

  // Base 3D coordinate mapping lines defining your permanent 6ft framework
  final List<v64.Vector3> _skeletalVertices = [
    v64.Vector3(0.0, 1.83, 0.0),   // Top Node (1.83 meters = exactly 6 feet)
    v64.Vector3(0.45, 0.95, 0.2),  // Mid-Right perspective vector
    v64.Vector3(-0.45, 0.95, -0.2), // Mid-Left perspective vector
    v64.Vector3(0.0, 0.0, 0.0),    // Pin ground anchor
  ];

  @override
  void paint(Canvas canvas, Size size) {
    // 2. Setup the premium Neon Cyan dual-layered paint brushes
    final Paint neonAuraBrush = Paint()
      ..color = const Color(0xFF00F3FF).withOpacity(0.35 + (Offset(scale, shiftY).distance % 0.15)) // Subtle pulse effect
      ..strokeWidth = 14.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5.0);

    final Paint coreLaserBrush = Paint()
      ..color = const Color(0xFFE6FFFF)
      ..strokeWidth = 3.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 3. Initialize layout transformation space centered on the viewport horizon
    // FIXED: Upgraded matrix compilation logic to eliminate deprecated warnings
    final v64.Matrix4 localViewportTransform = v64.Matrix4.identity()
      ..translateByDouble(size.width / 2, size.height * (0.8 + shiftY)) 
      ..scale(120.0 * scale, -120.0 * scale); 

    // Combine your live ticker projection calculations with the local layout space
    final v64.Matrix4 absoluteTransformationMatrix = localViewportTransform * matrix;

    List<Offset> projectedNodes = [];
    for (var position3d in _skeletalVertices) {
      // Direct high-speed 3D point cloud transformation pass
      final v64.Vector3 compiledVector = absoluteTransformationMatrix.transform3(v64.Vector3.copy(position3d));
      projectedNodes.add(Offset(compiledVector.x, compiledVector.y));
    }

    // 4. Assemble the structural vector paths onto the viewport coordinates
    if (projectedNodes.length >= 4) {
      final Path structurePath = Path()
        ..moveTo(projectedNodes[3].dx, projectedNodes[3].dy) // Ground point
        ..lineTo(projectedNodes[2].dx, projectedNodes[2].dy) // Connect to mid-left
        ..lineTo(projectedNodes[0].dx, projectedNodes[0].dy) // Connect to crown
        ..lineTo(projectedNodes[1].dx, projectedNodes[1].dy) // Connect to mid-right
        ..close();

      // Double-pass rendering to synthesize the bright neon core light aura
      canvas.drawPath(structurePath, neonAuraBrush);
      canvas.drawPath(structurePath, coreLaserBrush);
      
      // Draw sharp vertex node terminals
      final Paint nodeBrush = Paint()..color = Colors.white;
      for (var node in projectedNodes) {
        canvas.drawCircle(node, 5.0, nodeBrush);
      }
    }
  }

  @override
  bool shouldRepaint(covariant HolographicMeshPainter oldDelegate) {
    // Keep rendering continuously synced directly with your parent's structural ticker matrices
    return oldDelegate.matrix != matrix || oldDelegate.time != time;
  }
}
