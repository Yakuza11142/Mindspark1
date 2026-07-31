import 'dart:async';
import 'package:flutter/foundation.dart';

// Stand-in architecture assumptions for your core services
abstract class StreamableBrainEngine {
  Stream<String> generateLessonStream(String input);
}

abstract class QueueAudioService {
  Future<void> enqueueAndSpeak(String textChunk);
  Future<void> stopAllPlayback();
}

class VoiceChatEngine {
  // FIXED: Converted instances into unified private singletons to prevent 
  // duplicate network allocations and overlapping background audio loops.
  static final VoiceChatEngine _instance = VoiceChatEngine._internal();
  factory VoiceChatEngine() => _instance;
  VoiceChatEngine._internal();

  // Replace these with your actual BrainEngine and AudioService singletons
  final dynamic _brainEngine = dynamic; 
  final dynamic _audioService = dynamic;

  bool _isCurrentlyProcessing = false;

  /// Process inbound voice text loops using high-efficiency sentence stream pipelines
  Future<void> processVoiceConversation(String userVoiceInput) async {
    if (userVoiceInput.trim().isEmpty) return;

    // Interrupt previous playback loops if the user cuts off the AI by speaking again
    if (_isCurrentlyProcessing) {
      await _audioService.stopAllPlayback();
    }

    _isCurrentlyProcessing = true;
    debugPrint("🎙️ [VoiceChat Pipeline] Initializing zero-lag conversational routing...");

    StringBuffer sentenceBuffer = StringBuffer();

    try {
      // FIXED: Swapped out linear strings for real-time text Streams.
      // Assumes your BrainEngine has been updated to emit chunks: .generateLessonStream()
      final Stream<String> textStream = _brainEngine.generateLessonStream(userVoiceInput);

      await for (final String textChunk in textStream) {
        sentenceBuffer.write(textChunk);
        final String currentText = sentenceBuffer.toString();

        // Detect clean punctuation boundaries (periods, question marks, newlines) 
        // to pass naturally complete sentences to the speech engine instantly.
        if (currentText.contains('.') || currentText.contains('?') || currentText.contains('\n')) {
          final String sentenceToSpeak = currentText.trim();
          
          if (sentenceToSpeak.isNotEmpty) {
            // Beams the first sentence to the device speaker while sentence 2 is still compiling in the cloud!
            _audioService.enqueueAndSpeak(sentenceToSpeak);
            debugPrint("🔊 Pipelining audio chunk: \"$sentenceToSpeak\"");
          }
          
          sentenceBuffer.clear(); // Flush buffer to capture the next sibling sentence block
        }
      }

      // Handle any trailing text fragments left in the buffer after the stream closes
      final String remainingText = sentenceBuffer.toString().trim();
      if (remainingText.isNotEmpty) {
        _audioService.enqueueAndSpeak(remainingText);
      }

    } catch (e) {
      debugPrint("🚨 VoiceChat Engine Stream Intercept Fault: ${e.toString()}");
    } finally {
      _isCurrentlyProcessing = false;
    }
  }
}
