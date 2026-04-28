import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../services/camera_permission_enforcer.dart';
import '../services/ar_dependency_checker.dart';

class BulletproofHoloDeck extends StatefulWidget {
  final String modelUrl; 
  const BulletproofHoloDeck({super.key, required this.modelUrl});

  @override
  State<BulletproofHoloDeck> createState() => _BulletproofHoloDeckState();
}

class _BulletproofHoloDeckState extends State<BulletproofHoloDeck> {
  bool _cameraGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  void _checkPermissions() async {
    bool granted = await CameraPermissionEnforcer.requestCamera();
    if (mounted) setState(() => _cameraGranted = granted);
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraGranted) {
      return const Center(child: Text("Waiting for Camera Permission...", style: TextStyle(color: Colors.amber)));
    }

    return Stack(
      children:[
        // THE GUARANTEED VIEWER
        ModelViewer(
          // Use this Google Test link first to PROVE your phone works. 
          // Then change it back to widget.modelUrl
          src: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb', 
          ar: true,
          arModes: const ['scene-viewer', 'webxr', 'quick-look'], // SCENE-VIEWER is mandatory for Android
          arScale: ArScale.auto,
          arPlacement: ArPlacement.floor,
          autoRotate: true,
          cameraControls: true,
          backgroundColor: Colors.transparent,
        ),
        
        // THE FIX BUTTON (In case it still doesn't pop up)
        Positioned(
          top: 10, right: 10,
          child: IconButton(
            icon: const Icon(Icons.build_circle, color: Colors.redAccent, size: 30),
            tooltip: "Fix AR",
            onPressed: () => ArDependencyChecker.checkAndPrompt(context),
          ),
        )
      ],
    );
  }
}