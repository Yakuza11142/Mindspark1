import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class HoloFallbackViewer extends StatelessWidget {
  final String modelUrl;
  final bool arSupported;
  const HoloFallbackViewer({super.key, required this.modelUrl, required this.arSupported});

  @override
  Widget build(BuildContext context) {
    return ModelViewer(
      src: modelUrl,
      ar: arSupported, // If false, the AR button disappears. No crash.
      autoRotate: true,
      cameraControls: true,
      backgroundColor: Colors.black,
      alt: "A 3D educational model",
    );
  }
}