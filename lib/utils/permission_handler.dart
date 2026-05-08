import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkCamera() async {
    return await Permission.camera.request().isGranted;
  }
}