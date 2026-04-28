import 'package:permission_handler/permission_handler.dart';

class MicPermissionGate {
  static Future<bool> ensureMicAccess() async {
    PermissionStatus status = await Permission.microphone.status;
    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }
    return status.isGranted;
  }
}