import 'package:supabase_flutter/supabase_flutter.dart';

class RemoteWipeListener {
  static Future<void> checkStatus(String hwId) async {
    final res = await Supabase.instance.client.rpc('check_remote_wipe', params: {'p_hardware_id': hwId});
    if (res == true) {
      print("☠️ REMOTE WIPE INITIATED FROM HQ. DESTROYING LOCAL DATA.");
      // SharedPreferences.getInstance().then((prefs) => prefs.clear());
    }
  }
}