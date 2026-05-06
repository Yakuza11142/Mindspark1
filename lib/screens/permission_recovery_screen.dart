import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRecoveryScreen extends StatelessWidget {
  const PermissionRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.camera_alt_outlined, size: 80, color: Colors.red),
            const Text("Camera Access Needed for AR"),
            ElevatedButton(
              onPressed: () => openAppSettings(),
              child: const Text("Open Phone Settings"),
            )
          ],
        ),
      ),
    );
  }
}