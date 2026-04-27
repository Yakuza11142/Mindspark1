import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class VoiceInputService {
  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;

  // 1. INITIALIZE LISTENER
  Future<bool> init() async {
    // Ask for permission first
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) return false;

    _isAvailable = await _speech.initialize(
      onError: (e) => print("Voice Error: $e"),
      onStatus: (s) => print("Voice Status: $s"),
    );
    return _isAvailable;
  }

  // 2. START LISTENING
  void startListening(Function(String) onResult) {
    if (_isAvailable) {
      _speech.listen(
        onResult: (val) => onResult(val.recognizedWords),
        localeId: "en_NG", // Optimized for Nigerian English
      );
    }
  }

  // 3. STOP LISTENING
  void stopListening() {
    _speech.stop();
  }

  bool get isListening => _speech.isListening;
}