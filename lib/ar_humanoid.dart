import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as v;
import 'package:flutter/material.dart';

class ARHumanoid {
  final ArCoreController controller;
  final ArCoreMaterial glow = ArCoreMaterial(color: Colors.cyanAccent.withOpacity(0.4), metallic: 1);

  ARHumanoid(this.controller);

  void buildFullBody(v.Vector3 origin) {
    // --- TORSO & BACK ---
    _addNode(v.Vector3(0, 0.4, 0) + origin, ArCoreCylinder(materials: [glow], radius: 0.15, height: 0.5), "stomach_back");

    // --- FACE & HEAD ---
    _addNode(v.Vector3(0, 0.75, 0) + origin, ArCoreSphere(materials: [glow], radius: 0.12), "head");
    _addNode(v.Vector3(0.05, 0.78, 0.1) + origin, ArCoreSphere(materials: [glow], radius: 0.02), "eye_right");
    _addNode(v.Vector3(-0.05, 0.78, 0.1) + origin, ArCoreSphere(materials: [glow], radius: 0.02), "eye_left");

    // --- ARMS (IK Rigged) ---
    _buildLimb(origin, isLeg: false, isLeft: true);
    _buildLimb(origin, isLeg: false, isLeft: false);

    // --- LEGS (IK Rigged) ---
    _buildLimb(origin, isLeg: true, isLeft: true);
    _buildLimb(origin, isLeg: true, isLeft: false);
  }

  void _buildLimb(v.Vector3 origin, {required bool isLeg, required bool isLeft}) {
    double side = isLeft ? -1 : 1;
    double yPos = isLeg ? 0.15 : 0.6; // Shoulder vs Hip height
    
    // Joint 1: Shoulder/Hip
    _addNode(v.Vector3(side * 0.2, yPos, 0) + origin, ArCoreSphere(materials: [glow], radius: 0.05), "joint_start");
    
    // Bone 1: Upper Arm/Thigh
    _addNode(v.Vector3(side * 0.2, yPos - 0.2, 0) + origin, ArCoreCylinder(materials: [glow], radius: 0.04, height: 0.3), "bone_upper");
    
    // Joint 2: Elbow/Knee
    _addNode(v.Vector3(side * 0.2, yPos - 0.4, 0) + origin, ArCoreSphere(materials: [glow], radius: 0.04), "joint_mid");

    // Bone 2: Forearm/Shin
    _addNode(v.Vector3(side * 0.2, yPos - 0.6, 0) + origin, ArCoreCylinder(materials: [glow], radius: 0.03, height: 0.3), "bone_lower");

    // Joint 3: Hand/Foot
    _addNode(v.Vector3(side * 0.2, yPos - 0.75, 0) + origin, ArCoreSphere(materials: [glow], radius: 0.05), "effector");
  }

  void _addNode(v.Vector3 pos, ArCoreShape shape, String name) {
    final node = ArCoreNode(shape: shape, position: pos, name: name);
    controller.addArCoreNode(node);
  }
}
