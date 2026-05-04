import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

class CameraLifecycleManager extends WidgetsBindingObserver {
  CameraController? controller;

  void initCamera(CameraController c) {
    controller = c;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller!.value.isInitialized) return;
    
    if (state == AppLifecycleState.inactive) {
      controller?.dispose(); // Kill camera immediately to save RAM
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize camera when user returns
      print("Restoring camera stream...");
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
  }
}