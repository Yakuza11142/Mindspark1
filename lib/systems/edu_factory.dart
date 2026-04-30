import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:flutter/material.dart';

class EduFactory {
  // Instantly projects a data-orb near the AH hologram
  static void spawnLessonOrb(ArCoreController controller, v.Vector3 position, String lessonId) {
    final orbMaterial = ArCoreMaterial(
      color: Colors.blueAccent.withOpacity(0.7),
      metallic: 1.0,
    );

    final node = ArCoreNode(
      shape: ArCoreSphere(materials: [orbMaterial], radius: 0.15),
      position: position,
      name: lessonId, // This ID links to the specific lesson data
    );

    controller.addArCoreNode(node);
  }
}
