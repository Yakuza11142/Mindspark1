import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionManager {
  static Future<bool> ensureRequiredPermissions() async {
    // List of basic permissions
    List<Permission> permissions = [
      Permission.camera,
      Permission.microphone,
    ];

    // Handle Storage based on Android Version
    if (Platform.isAndroid) {
      // Android 13 (API 33) and above use specific media permissions
      // You must check the SDK version or just request these
      permissions.addAll([
        Permission.photos,
        Permission.videos,
        Permission.audio,
      ]);
    } else {
      // For older Android or iOS
      permissions.add(Permission.storage);
    }

    Map<Permission, PermissionStatus> statuses = await permissions.request();

    // Check if everything is granted
    bool allGranted = true;
    statuses.forEach((permission, status) {
      if (!status.isGranted) {
        allGranted = false;
      }
    });

    return allGranted;
  }
}
