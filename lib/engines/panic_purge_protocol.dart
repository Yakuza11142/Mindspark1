import 'package:shared_preferences/shared_preferences.dart';

class PanicPurgeProtocol {
  // THE KILL SWITCH
  static const bool isPanicModeDead = true; 

  static Future<void> eradicatePanicMode() async {
    final prefs = await SharedPreferences.getInstance();
    // Wipe all panic-inducing variables from the device
    await prefs.remove('jamb_panic_mode_active');
    await prefs.remove('exam_eve_lockdown');
    await prefs.remove('urgency_red_theme');
    print("🛑 PANIC MODE PURGED. Zen Learning Architecture Online.");
  }

  // Always returns false to any old widget asking for panic status
  static bool checkUrgency() => false; 
}