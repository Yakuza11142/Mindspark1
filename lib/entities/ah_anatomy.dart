import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:flutter/material.dart';

class AHAnatomy {
  final ArCoreController controller;

  AHAnatomy(this.controller);

  void buildCompleteHumanoid(v.Vector3 origin) {
    // 1. EXTERNAL SHELL (Transparent Skin)
    _addOrgan(origin + v.Vector3(0, 0.4, 0), 
      ArCoreCylinder(materials: [_skinMat()], radius: 0.2, height: 0.6), "skin_torso");

    // 2. THE BRAIN (Inside the Head)
    _addOrgan(origin + v.Vector3(0, 0.75, 0), 
      ArCoreSphere(materials: [_brainMat()], radius: 0.08), "internal_brain");

    // 3. THE VEIN SYSTEM (Red/Blue Lines)
    _buildVeinNetwork(origin);
  }

  // Materials
  ArCoreMaterial _skinMat() => ArCoreMaterial(color: Colors.blue.withOpacity(0.2), metallic: 0.1);
  ArCoreMaterial _brainMat() => ArCoreMaterial(color: Colors.pinkAccent, metallic: 0.5);
  ArCoreMaterial _veinMat(bool isArtery) => ArCoreMaterial(color: isArtery ? Colors.red : Colors.blue);

  void _buildVeinNetwork(v.Vector3 origin) {
    // Creating vertical "vein" cylinders inside the torso
    for (int i = 0; i < 3; i++) {
      _addOrgan(origin + v.Vector3(0.05 * i, 0.4, 0.02), 
        ArCoreCylinder(materials: [_veinMat(i % 2 == 0)], radius: 0.01, height: 0.5), "vein_$i");
    }
  }

  void _addOrgan(v.Vector3 pos, ArCoreShape shape, String name) {
    controller.addArCoreNode(ArCoreNode(shape: shape, position: pos, name: name));
  }
}
