import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkCamera(BuildContext context) async {
    // 1. Check the active current status before aggressively firing a request stream
    var status = await Permission.camera.status;

    if (status.isGranted) {
      return true;
    }

    // 2. If it's permanently denied, we must redirect them to System Settings
    if (status.isPermanentlyDenied) {
      if (context.mounted) {
        _showSettingsDialog(context);
      }
      return false;
    }

    // 3. Otherwise, fire a fresh native OS permission prompt request
    final result = await Permission.camera.request();
    return result.isGranted;
  }

  // 4. Clean dialog informs the user exactly how to unblock their AR view camera channel
  static void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Camera Permission Required"),
          content: const Text(
            "Mind Spark needs camera access to render your 6ft AI Tutor & AR Lab experiments. Please enable it in your device settings."
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00E5FF)),
              onPressed: () async {
                Navigator.pop(context);
                await openAppSettings(); // Fires the native OS App Settings panel instantly
              },
              child: const Text("Open Settings", style: TextStyle(color: Colors.black87)),
            ),
          ],
        );
      },
    );
  }
}
