import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../engines/ar_foot_ik_solver.dart';
import '../engines/skeletal_animation_controller.dart';

class FullBodyArRenderer extends StatelessWidget {
  final String characterName;
  final String modelUrl;

  const FullBodyArRenderer({super.key, required this.characterName, required this.modelUrl});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: modelUrl, // The compiled .glb file containing the full body + clothes
      ar: true,
      arPlacement: ArPlacement.floor,
      autoAnimate: true,
      animationName: SkeletalAnimationController.getIdleAnimation(characterName),
      cameraControls: true,
      backgroundColor: Colors.transparent,
      // Adds shadows so their shoes actually look like they are touching your real floor
      shadowIntensity: 2.0, 
      relatedCss: ArFootIkSolver.applyFloorConstraint(),
    );
  }
}