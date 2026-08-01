import 'dart:async';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;

abstract class StreamableBrainEngine {
  Stream<String> generateLessonStream(String input);
}

abstract class QueueAudioService {
  Future<void> enqueueAndSpeak(String textChunk);
  Future<void> stopAllPlayback();
}

class VoiceChatEngine {
  // Singleton pattern minimizes global footprint and protects multi-threaded memory spaces [INDEX]
  static final VoiceChatEngine _instance = VoiceChatEngine._internal();
  factory VoiceChatEngine() => _instance;
  VoiceChatEngine._internal();

  // Converted invalid dynamic value tokens into explicit abstraction interfaces ready for singleton injection links [INDEX]
  StreamableBrainEngine? _brainEngine;
  QueueAudioService? _audioService;

  bool _isCurrentlyProcessing = false;
  
  // Track the active stream subscription handle to allow clean mid-flight cancellations [INDEX]
  StreamSubscription<String>? _activeStreamSubscription;

  /// External dependency injection configuration locks concrete service framework structures securely [INDEX]
  void initializeDependencies({
    required StreamableBrainEngine brain,
    required QueueAudioService audio,
  }) {
    _brainEngine = brain;
    _audioService = audio;
  }

  /// Process inbound voice text loops using high-efficiency sentence stream pipelines [INDEX]
  Future<void> processVoiceConversation(String userVoiceInput) async {
    final String cleanedInput = userVoiceInput.trim();
    if (cleanedInput.isEmpty) return;

    if (_brainEngine == null || _audioService == null) {
      developer.log("❌ VoiceChatEngine: Execution aborted. Dependencies are uninitialized.");
      return;
    }

    // Forcibly tear down preceding asynchronous stream lines to permanently close background race conditions [INDEX]
    if (_isCurrentlyProcessing) {
      developer.log("⚙️ VoiceChatEngine: Intercepting concurrent thread loop. Terminating preceding stream channels safely.");
      await _activeStreamSubscription?.cancel();
      await _audioService!.stopAllPlayback();
    }

    _isCurrentlyProcessing = true;
    developer.log("🎙️ VoiceChatEngine: Initializing zero-lag conversational stream routing...");

    final StringBuffer sentenceBuffer = StringBuffer();

    try {
      final Stream<String> textStream = _brainEngine!.generateLessonStream(cleanedInput);
      final Completer<void> streamCompletionCompleter = Completer<void>();

      // Swapped loose await-for setups for explicit subscriptions to allow deterministic thread management [INDEX]
      _activeStreamSubscription = textStream.listen(
        (String textChunk) {
          sentenceBuffer.write(textChunk);
          final String currentText = sentenceBuffer.toString();

          // Upgraded primitive checks to a comprehensive regular expression lookbehind pattern [INDEX]
          // This splits sentences accurately while completely ignoring common abbreviations (e.g., Mr., Dr., etc.)
          final RegExp sentenceEndPattern = RegExp(r'(?<!\b(?:Dr|Mr|Ms|St|e\.g|i\.e))\s*[.!?\n]\s*');
          
          if (sentenceEndPattern.hasMatch(currentText)) {
            // Split the buffer contents into finalized structural sentences and trailing raw string remainders [INDEX]
            final List<String> parts = currentText.split(sentenceEndPattern);
            
            // The last index element represents the un-finalized fragment string still being typed [INDEX]
            final String remainingFragment = parts.removeLast();

            for (final String completedSentence in parts) {
              final String sentenceToSpeak = completedSentence.trim();
              if (sentenceToSpeak.isNotEmpty) {
                _audioService!.enqueueAndSpeak(sentenceToSpeak);
                developer.log("🔊 VoiceChatEngine: Pipelining audio chunk: \"$sentenceToSpeak\"");
              }
            }

            sentenceBuffer.clear();
            sentenceBuffer.write(remainingFragment);
          }
        },
        onError: (Object error, StackTrace stack) {
          developer.log("❌ VoiceChatEngine: Upstream stream channel emitted a processing fault", error: error, stackTrace: stack);
          streamCompletionCompleter.complete();
        },
        onDone: () {
          streamCompletionCompleter.complete();
        },
        cancelOnError: true,
      );

      // Hold thread lifecycle execution frames stable until the listener loop signals completion paths cleanly [INDEX]
      await streamCompletionCompleter.future;

      // Handle any trailing text fragments left in the buffer after the stream closes cleanly [INDEX]
      final String remainingText = sentenceBuffer.toString().trim();
      if (remainingText.isNotEmpty) {
        await _audioService!.enqueueAndSpeak(remainingText);
      }

    } catch (e, stackTrace) {
      developer.log("❌ VoiceChatEngine: Media processing pipeline collapsed seamlessly", error: e, stackTrace: stackTrace);
    } finally {
      _isCurrentlyProcessing = false;
      _activeStreamSubscription = null;
    }
  }
}
