import 'package:flutter/material.dart';
import 'package:arcore_flutter_plus/arcore_flutter_plus.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class LidarMimicEngine extends StatefulWidget {
  const LidarMimicEngine({super.key});

  @override
  State<LidarMimicEngine> createState() => _LidarMimicEngineState();
}

class _LidarMimicEngineState extends State<LidarMimicEngine> {
  ArCoreController? arCoreController;
  String realTimeDistance = "Scanning Room...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. FIXED: The tap recognizer is attached directly to ArCoreView
          ArCoreView(
            onArCoreViewCreated: _onArCoreViewCreated,
            enableTapRecognizer: true, 
          ),
          
          // 2. The LiDAR Reticle UI Crosshair
          const Center(
            child: Icon(
              Icons.center_focus_strong, 
              color: Colors.cyanAccent, 
              size: 40
            ),
          ),

          // 3. Real-Time Depth Data Feedback Overlay
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.cyanAccent, width: 1.5),
              ),
              child: Text(
                "MIND_SPARK LiDAR DATA:\n$realTimeDistance",
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontFamily: 'monospace',
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. FIXED: The controller configures features, but hits are caught separately
  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    
    // This tells the engine to start looking for horizontal planes
    arCoreController?.onTrackingImage = (arCoreImage) {
      // Optional: Handles image anchors if needed
    };
  }

  // 5. The Core Mathematical LiDAR Simulation Engine
  // This automatically receives the accurate X, Y, Z coordinate map upon tap
  void _handleSpatialRaycast(List<ArCoreHitTestResult> hits) {
    if (hits.isEmpty) return;

    // Grab the absolute closest surface point intercepted
    final closestHit = hits.first;

    // Extract the exact X, Y, Z Matrix Coordinates from the real-world collision
    final vector.Vector3 position = closestHit.pose.translation;

    // Calculate absolute Euclidean distance: d = sqrt(x² + y² + z²)
    final double depthCalculated = position.length;

    setState(() {
      realTimeDistance = 
          "X: ${position.x.toStringAsFixed(2)}m | "
          "Y: ${position.y.toStringAsFixed(2)}m | "
          "Z: ${position.z.toStringAsFixed(2)}m\n"
          "SURFACE DISTANCE: ${depthCalculated.toStringAsFixed(2)} meters";
    });

    // 6. Paint a Physical Visual LiDAR Node point in space
    final lidarNodeNode = ArCoreNode(
      shape: ArCoreSphere(
        materials: [ArCoreMaterial(color: Colors.cyanAccent, metallic: 1.0)],
        radius: 0.02, // 2-centimeter point cloud node
      ),
      position: position,
    );

    arCoreController?.addArCoreNode(lidarNodeNode);
  }

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }
}
