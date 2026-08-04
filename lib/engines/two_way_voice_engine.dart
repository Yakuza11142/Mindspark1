import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Abstract structural definitions reflecting your app architecture
abstract class AudioService {
  static AudioService? _instance;
  
  static AudioService get instance {
    if (_instance == null) {
      throw StateError("🚨 AudioService.instance accessed before assignment. Inject a real implementation.");
    }
    return _instance!;
  }

  static set instance(AudioService service) => _instance = service;

  Future<void> speak(String text);
  Future<void> stop();
}

abstract class SparkAiCore {
  static Future<String> generateResponse(String input, bool isPro, bool isSpark) async => "";
}

class TwoWayVoiceEngine {
  static final SpeechToText _stt = SpeechToText();
  static bool _isConversing = false;
  static bool _isProcessingState = false;

  /// Establishes the non-blocking two-way continuous voice pipeline loop
  static Future<void> startConversation(String persona, bool isPro) async {
    if (_isConversing) return;
    _isConversing = true;
    _isProcessingState = false;

    debugPrint("🎙️ Two-Way Audio Link Established with $persona");

    try {
      final bool initialized = await _stt.initialize(
        onError: (errorNotification) => debugPrint("⚠️ STT Error: $errorNotification"),
        onStatus: (statusEvent) => debugPrint("📡 STT Status updated: $statusEvent"),
      );

      if (initialized && _isConversing) {
        await _listenLoop(persona, isPro);
      }
    } catch (e) {
      debugPrint("🚨 Failed to initialize native audio hardware capture channels: $e");
      endConversation();
    }
  }

  /// Safe operational pipeline loop protected against rapid audio-frame race conditions
  static Future<void> _listenLoop(String persona, bool isPro) async {
    if (!_isConversing || _isProcessingState) return;

    if (_stt.isListening) {
      await _stt.stop();
    }

    await _stt.listen(
      options: SpeechListenOptions(
        listenMode: ListenMode.confirmation,
      ),
      pauseFor: const Duration(seconds: 2), 
      onResult: (result) async {
        // Synchronous processing guard blocks multi-thread loop duplicate race triggers
        if (result.finalResult && _isConversing && !_isProcessingState) {
          _isProcessingState = true; 

          final String userSpoke = result.recognizedWords;
          debugPrint("👤 User: $userSpoke");

          try {
            await _stt.stop();

            // 1. Fetch AI response smoothly from the cloud engine
            final String aiReply = await SparkAiCore.generateResponse(
              userSpoke, 
              isPro, 
              persona == "Spark",
            );
            debugPrint("🤖 AI Reply Generated: $aiReply");

            if (!_isConversing) return;

            // 2. Fully awaited audio feedback pipeline blocks the mic until complete
            await AudioService.instance.speak(aiReply);

            // 3. Controlled recursive loop reactivation
            if (_isConversing) {
              _isProcessingState = false;
              await _listenLoop(persona, isPro);
            }

          } catch (pipelineError) {
            debugPrint("🚨 Voice engine processing loop failure: ${pipelineError.toString()}");
            _isProcessingState = false;
            if (_isConversing) await _listenLoop(persona, isPro);
          }
        }
      },
    );
  }

  /// Cleanly tears down all hardware links and flushes background loops safely
  static Future<void> endConversation() async {
    _isConversing = false;
    _isProcessingState = false;
    try {
      await _stt.stop();
      await AudioService.instance.stop();
      debugPrint("🔒 Two-Way Voice Engine disconnected safely.");
    } catch (e) {
      debugPrint("🚨 Error closing voice channels: $e");
    }
  }
}
