import 'package:vibration/vibration.dart';

class HapticSettings {
  // Global registry for haptic patterns (The Data)
  static final Map<String, List<int>> patterns = {};

  // Global toggle to enable/disable haptics across the entire app
  static bool isEnabled = true;

  static void addPattern(String key, List<int> sequence) {
    patterns[key] = sequence;
  }
}

class HapticEngineReal {
  // The Logic
  static Future<void> play(String effectName) async {
    if (!HapticSettings.isEnabled) return;

    final pattern = HapticSettings.patterns[effectName];
    
    if (pattern != null && (await Vibration.hasCustomVibrationsSupport() ?? false)) {
      Vibration.vibrate(pattern: pattern);
    }
  }
}
