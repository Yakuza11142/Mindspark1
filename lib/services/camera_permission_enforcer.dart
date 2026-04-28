import 'package:permission_handler/permission_handler.dart';

class CameraPermissionEnforcer {
  static Future<bool> requestCamera() async {
    PermissionStatus status = await Permission.camera.status;
    
    if (!status.isGranted) {
      print("📷 Requesting Camera Permission for Holo-Deck...");
      status = await Permission.camera.request();
    }
    
    if (status.isGranted) {
      return true;
    } else {
      print("❌ Camera Permission Denied. AR cannot launch.");
      return false;
    }
  }
}