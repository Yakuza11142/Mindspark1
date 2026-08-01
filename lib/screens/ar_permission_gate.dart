import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

class ArPermissionGate extends StatefulWidget {
  final Widget child; // The premium AR viewing layout to display once access is confirmed

  const ArPermissionGate({super.key, required this.child});

  @override
  State<ArPermissionGate> createState() => _ArPermissionGateState();
}

class _ArPermissionGateState extends State<ArPermissionGate> {
  bool _hasCameraAccess = false;
  bool _isLoading = true;
  
  // Track an explicit structural handle reference to listen for app resume triggers securely [INDEX]
  AppLifecycleListener? _lifecycleListener;

  @override
  void initState() {
    super.initState();
    
    // Properly initialize the concrete lifecycle listener to re-verify permissions when users return from settings [INDEX]
    _lifecycleListener = AppLifecycleListener(
      onResume: () {
        developer.log("⚙️ ArPermissionGate: App resumed from background. Re-evaluating camera parameters.");
        _checkAndRequestArPermissions();
      },
    );

    _checkAndRequestArPermissions();
  }

  /// Dispatches the explicit hardware-level privacy token evaluation loop securely [INDEX]
  Future<void> _checkAndRequestArPermissions() async {
    developer.log("⚙️ ArPermissionGate: Evaluating low-level operating system privacy registers.");

    try {
      final PermissionStatus status = await Permission.camera.status;

      if (status.isGranted) {
        _transitionToArView();
        return;
      }

      if (status.isDenied || status.isLimited) {
        final PermissionStatus requestResult = await Permission.camera.request();
        if (requestResult.isGranted) {
          _transitionToArView();
          return;
        }
      }

      if (mounted) {
        setState(() {
          _hasCameraAccess = false;
          _isLoading = false;
        });
      }
    } catch (e, stackTrace) {
      developer.log("❌ ArPermissionGate: Platform permission handshake collapsed", error: e, stackTrace: stackTrace);
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _transitionToArView() {
    if (!mounted) return;
    setState(() {
      _hasCameraAccess = true;
      _isLoading = false;
    });
    developer.log("✅ ArPermissionGate: Privacy credentials approved. Launching spatial mesh viewport.");
  }

  // Explicitly override the dispose hook to clean up lifecycle listeners and protect against memory leaks [INDEX]
  @override
  void dispose() {
    _lifecycleListener?.dispose();
    developer.log("⚙️ ArPermissionGate: Lifecycle listener destroyed cleanly.");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent),
        ),
      );
    }

    if (_hasCameraAccess) {
      return widget.child;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videocam_off_rounded, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              "Camera Access Required",
              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              "MindSpark uses the camera to anchor spatial 3D lessons onto your real-world surface planes. Please enable camera access in your system settings.",
              style: TextStyle(fontSize: 16, color: Colors.white60),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings, size: 20),
              label: const Text("OPEN DEVICE SETTINGS"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                await openAppSettings();
              },
            ),
          ],
        ),
      ),
    );
  }
}
