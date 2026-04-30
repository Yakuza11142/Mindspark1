import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:flutter/material.dart';

class HologramFactory {
  // Instant Spawn: 0s delay
  static void spawnInstant(ArCoreController controller, v.Vector3 position, String id) {
    final node = ArCoreNode(
      shape: ArCoreCube(
        materials: [ArCoreMaterial(color: Colors.cyan, metallic: 1.0)],
        size: v.Vector3(0.2, 0.2, 0.2),
      ),
      position: position,
      name: id,
    );
    
    // Direct injection into the AR Scene
    controller.addArCoreNode(node);
  }

  static void destroyInstant(ArCoreController controller, String id) {
    controller.removeNode(nodeName: id);
  }
}
