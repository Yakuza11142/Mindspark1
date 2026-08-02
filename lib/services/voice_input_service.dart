import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

class VoiceInputService extends ChangeNotifier {
  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;
  
  // Decoupled Configuration Tokens
  static const String _defaultLocale = "en_NG";
  static const Duration _listenTimeout = Duration(seconds: 30);
  static const Duration _pauseThreshold = Duration(seconds: 5);

  bool get isAvailable => _isAvailable;
  bool get isListening => _speech.isListening;

  /// Requests hardware access permissions and initializes native speech engine pipelines asynchronously
  Future<bool> initializeService() async {
    try {
      final PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        _isAvailable = false;
        notifyListeners();
        return false;
      }

      _isAvailable = await _speech.initialize(
        onError: _handleVoiceError,
        onStatus: _handleVoiceStatus,
      );
      
      notifyListeners();
      return _isAvailable;
    } catch (error, stack) {
      developer.log("❌ Speech init failure", error: error, stackTrace: stack);
      _isAvailable = false;
      return false;
    }
  }

  /// Establishes an active speech stream capturing incoming microphone input waveforms
  void startListeningSession({
    required Function(String) onWordsRecognized,
    Function(double)? onSoundLevelChanged,
  }) {
    if (!_isAvailable) {
      developer.log("⚠️ Speech recognition engine not initialized or accessible.");
      return;
    }

    _speech.listen(
      onResult: (speechResult) {
        onWordsRecognized(speechResult.recognizedWords);
      },
      onSoundLevelChange: onSoundLevelChanged,
      localeId: _defaultLocale,
      listenFor: _listenTimeout, // Force cutoff safety boundary 
      pauseFor: _pauseThreshold, // Stop automatically if user stops speaking
    );
    
    notifyListeners();
  }

  /// Signals the native platform layer to cease microphone recording passes
  void stopListeningSession() {
    _speech.stop();
    notifyListeners();
  }

  void _handleVoiceStatus(String systemStatus) {
    developer.log("🎙️ Speech Status update: $systemStatus");
    notifyListeners(); // Keep UI states perfectly in sync with background state shifts
  }

  void _handleVoiceError(SpeechRecognitionError errorDetails) {
    developer.log("🚨 Speech Recognition Error encountered: ${errorDetails.errorMsg}");
    notifyListeners(); // Wipe active visual indicators if a timeout or error drops the session
  }
}
