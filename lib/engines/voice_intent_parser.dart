import 'dart:async';
import 'dart:developer' as developer;

abstract class StreamableBrainEngine {
  Stream<String> generateLessonStream(String input);
}

abstract class QueueAudioService {
  Future<void> enqueueAndSpeak(String textChunk);
  Future<void> stopAllPlayback();
}

class VoiceChatEngine {
  static final VoiceChatEngine _instance = VoiceChatEngine._internal();
  factory VoiceChatEngine() => _instance;
  VoiceChatEngine._internal();

  StreamableBrainEngine? _brainEngine;
  QueueAudioService? _audioService;

  bool _isCurrentlyProcessing = false;
  StreamSubscription<String>? _activeStreamSubscription;

  /// External dependency injection configuration locks concrete service framework structures securely
  void initializeDependencies({
    required StreamableBrainEngine brain,
    required QueueAudioService audio,
  }) {
    _brainEngine = brain;
    _audioService = audio;
  }

  /// Process inbound voice text loops using high-efficiency sentence stream pipelines
  Future<void> processVoiceConversation(String userVoiceInput) async {
    final String cleanedInput = userVoiceInput.trim();
    if (cleanedInput.isEmpty) return;

    if (_brainEngine == null || _audioService == null) {
      developer.log("❌ VoiceChatEngine: Execution aborted. Dependencies are uninitialized.");
      return;
    }

    if (_isCurrentlyProcessing) {
      developer.log("⚙️ VoiceChatEngine: Intercepting concurrent thread loop. Terminating preceding stream channels safely.");
      await _activeStreamSubscription?.cancel();
      await _audioService!.stopAllPlayback();
    }

    _isCurrentlyProcessing = true;
    developer.log("🎙️ VoiceChatEngine: Initializing zero-lag conversational stream routing...");

    final StringBuffer sentenceBuffer = StringBuffer();
    // FIXED: Wrapped pattern in capture parenthesis to preserve punctuation characters during splits
    final RegExp sentenceEndPattern = RegExp(r'((?<!\b(?:Dr|Mr|Ms|St|e\.g|i\.e))\s*[.!?\n]\s*)');

    try {
      final Stream<String> textStream = _brainEngine!.generateLessonStream(cleanedInput);
      final Completer<void> streamCompletionCompleter = Completer<void>();

      _activeStreamSubscription = textStream.listen(
        (String textChunk) {
          sentenceBuffer.write(textChunk);
          final String currentText = sentenceBuffer.toString();

          if (sentenceEndPattern.hasMatch(currentText)) {
            // FIXED: Using split keeps matched delimiters in the array as alternating items
            final List<String> parts = currentText.split(sentenceEndPattern);
            
            // Re-allocate the un-finalized fragment at the very end
            final String remainingFragment = parts.isNotEmpty ? parts.removeLast() : "";

            // Systematically stitch sentences back to their trailing punctuation marks
            for (int i = 0; i < parts.length; i += 2) {
              if (i + 1 < parts.length) {
                final String finalizedSentence = (parts[i] + parts[i + 1]).trim();
                if (finalizedSentence.isNotEmpty) {
                  _audioService!.enqueueAndSpeak(finalizedSentence);
                  developer.log("🔊 VoiceChatEngine: Pipelining audio chunk: \"$finalizedSentence\"");
                }
              } else {
                final String isolatedFragment = parts[i].trim();
                if (isolatedFragment.isNotEmpty) {
                  _audioService!.enqueueAndSpeak(isolatedFragment);
                }
              }
            }

            sentenceBuffer.clear();
            sentenceBuffer.write(remainingFragment);
          }
        },
        onError: (Object error, StackTrace stack) {
          developer.log("❌ VoiceChatEngine: Upstream stream channel emitted a processing fault", error: error, stackTrace: stack);
          if (!streamCompletionCompleter.isCompleted) streamCompletionCompleter.complete();
        },
        onDone: () {
          // FIXED: Pipelining trailing fragments immediately inside onDone before state unlocks
          final String remainingText = sentenceBuffer.toString().trim();
          if (remainingText.isNotEmpty) {
            _audioService!.enqueueAndSpeak(remainingText);
            developer.log("🔊 VoiceChatEngine: Pipelining trailing audio chunk: \"$remainingText\"");
          }
          if (!streamCompletionCompleter.isCompleted) streamCompletionCompleter.complete();
        },
        cancelOnError: true,
      );

      await streamCompletionCompleter.future;

    } catch (e, stackTrace) {
      developer.log("❌ VoiceChatEngine: Media processing pipeline collapsed seamlessly", error: e, stackTrace: stackTrace);
    } finally {
      _isCurrentlyProcessing = false;
      _activeStreamSubscription = null;
    }
  }
}
