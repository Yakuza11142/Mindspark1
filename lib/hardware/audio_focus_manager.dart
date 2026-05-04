import 'package:audio_session/audio_session.dart';

class AudioFocusManager {
  static Future<void> requestFocus() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playback,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.assistant,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gainTransientMayDuck, // Lowers Spotify volume
    ));
    await session.setActive(true);
  }
}