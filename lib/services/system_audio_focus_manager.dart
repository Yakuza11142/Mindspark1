// Requires audio_session package
import 'package:audio_session/audio_session.dart';

class AudioFocusManager {
  static Future<void> duckOthers() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    await session.setActive(true);
  }
}