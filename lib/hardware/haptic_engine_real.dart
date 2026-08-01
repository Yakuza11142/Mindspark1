import 'package:vibration/vibration.dart';
import 'dart:developer' as developer;

class HapticEngine {
  // Singleton pattern enforces a single unified tracking footprint across all hardware isolates
  HapticEngine._internal() {
    _loadDefaultSystemHapticProfiles();
  }
  static final HapticEngine instance = HapticEngine._internal();

  // Class properties isolated cleanly within the specific instance scope to prevent multi-threaded cross-talk
  final Map<String, List<int>> _compiledPatternsRegistry = {};
  bool isEnabled = true;

  /// Registers a new rhythmic vibration duration array pattern cleanly within your instance dictionary
  void registerPattern(String key, List<int> sequence) {
    final String cleanedKey = key.trim().toUpperCase();
    if (cleanedKey.isEmpty || sequence.isEmpty) return;

    // Filter and sanitize the sequence array to ensure zero negative durations pass to the hardware layers
    final List<int> sanitizedSequence = sequence.map((val) => val < 0 ? 0 : val).toList();

    _compiledPatternsRegistry[cleanedKey] = sanitizedSequence;
    developer.log("🛰️ HapticEngine: Dynamic vibration pattern initialized safely: [$cleanedKey]");
  }

  /// Triggers a specific rhythmic hardware feedback sequence safely with robust platform exception shields
  Future<void> play(String effectName) async {
    if (!isEnabled) return;

    final String cleanedKey = effectName.trim().toUpperCase();
    
    // Formulate a local snapshot copy of the pattern registry to prevent concurrent modification exceptions
    final Map<String, List<int>> activeRegistrySnapshot = Map<String, List<int>>.from(_compiledPatternsRegistry);
    final List<int>? pattern = activeRegistrySnapshot[cleanedKey];

    if (pattern == null || pattern.isEmpty) {
      developer.log("⚠️ HapticEngine: Requested pattern index tracking returns unpopulated: [$cleanedKey]");
      return;
    }

    try {
      // Query low-level native hardware capability markers safely
      final bool? supportsCustomVibrations = await Vibration.hasCustomVibrationsSupport();
      
      if (supportsCustomVibrations == true) {
        // Enforce explicit list typing bounds to guarantee stable native bridge data serialization
        await Vibration.vibrate(
          pattern: List<int>.from(pattern),
          intensities: List<int>.filled(pattern.length, 255), // Explicit peak amplitude pairing prevents Android channel mutes
        );
        developer.log("✅ HapticEngine: Successfully dispatched hardware vibration for effect: $cleanedKey");
      } else {
        // Safe baseline device rumble fallback if custom multi-duration arrays are rejected by hardware registers
        await Vibration.vibrate(duration: 100);
      }
    } catch (e, stackTrace) {
      developer.log("❌ HapticEngine: Native haptic channel invocation collapsed smoothly", error: e, stackTrace: stackTrace);
    }
  }

  /// Populates baseline configuration properties to ensure the playback matrix never runs empty
  void _loadDefaultSystemHapticProfiles() {
    registerPattern("SUCCESS", [0, 100, 50, 100]); // Delay, Vibrate, Pause, Vibrate
    registerPattern("FAILURE", [0, 200, 100, 200, 50, 300]);
    registerPattern("LIGHT_TAP", [0, 40]);
  }

  /// Clear registry helper to allow clean workspace resets during hot-reloads safely
  void resetRegistry() {
    developer.log("⚙️ HapticEngine: Purging active haptic registry indices. Reverting to base definitions.");
    _compiledPatternsRegistry.clear();
    _loadDefaultSystemHapticProfiles();
  }
}
