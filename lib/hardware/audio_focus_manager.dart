import 'package:audio_session/audio_session.dart';
import 'dart:developer' as developer;

class AudioFocusManager {
  // Singleton pattern enforces a single unified tracking footprint across all hardware isolates [INDEX]
  AudioFocusManager._internal();
  static final AudioFocusManager instance = AudioFocusManager._internal();

  static AudioSession? _cachedSession;
  static bool _isConfigured = false;

  /// Private helper method ensuring thread-safe, single-pass plugin binding setup lookups [INDEX]
  static Future<AudioSession> _getSafeSession() async {
    if (_cachedSession != null) return _cachedSession!;
    _cachedSession = await AudioSession.instance;
    return _cachedSession!;
  }

  /// Configures and secures transient media request focus boundaries aggressively [INDEX]
  static Future<void> requestFocus() async {
    developer.log("🔊 AudioFocusManager: Registering temporary hardware focus parameters.");

    try {
      final AudioSession session = await _getSafeSession();

      if (!_isConfigured) {
        await session.configure(const AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playback,
          avAudioSessionMode: AVAudioSessionMode.spokenAudio,
          avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
          avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
          androidAudioAttributes: AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            flags: AndroidAudioFlags.none,
            usage: AndroidAudioUsage.media, // Swapped to media to guarantee stable global cross-app ducking [INDEX]
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck, 
        ));
        _isConfigured = true;
      }

      // Securely grab the active line connection [INDEX]
      await session.setActive(true);
      developer.log("✅ AudioFocusManager: Native background ducking parameters successfully engaged.");
    } catch (e, stackTrace) {
      developer.log("❌ AudioFocusManager: Failed to request native media focus parameters safely", error: e, stackTrace: stackTrace);
    }
  }

  /// Call this release hook the exact millisecond playback stops to restore global device audio profiles cleanly [INDEX]
  static Future<void> abandonFocus() async {
    developer.log("⚙️ AudioFocusManager: Releasing background audio session locks cleanly.");
    try {
      if (_cachedSession != null) {
        // Notify the operating system to safely release hardware hooks and step down your focus tracking loops [INDEX]
        await _cachedSession!.setActive(false);
        developer.log("✅ AudioFocusManager: Focus abandoned. Companion audio streams restored to maximum amplitude.");
      }
    } catch (e, stackTrace) {
      developer.log("⚠️ AudioFocusManager: Clean focus release session aborted gracefully", error: e, stackTrace: stackTrace);
    }
  }
}
