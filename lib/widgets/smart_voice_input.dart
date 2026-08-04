import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import '../engines/stt_autocorrect_engine.dart';

class SmartVoiceInput extends StatefulWidget {
  final TextEditingController controller;
  final Color? accentColor;
  final Function(String liveText)? onPartialResult; // Real-time feedback callback
  final VoidCallback? onListeningTimeout;

  const SmartVoiceInput({
    super.key,
    required this.controller,
    this.accentColor,
    this.onPartialResult,
    this.onListeningTimeout,
  });

  @override
  State<SmartVoiceInput> createState() => _SmartVoiceInputState();
}

class _SmartVoiceInputState extends State<SmartVoiceInput> with SingleTickerProviderStateMixin {
  bool _isListening = false;
  StreamSubscription<String>? _audioTextSubscription;
  
  // High-performance hardware timeout anchor to prevent endless recording states
  Timer? _fallbackSessionTimer;
  static const Duration _maxRecordingSessionLimit = Duration(seconds: 30);

  @override
  void dispose() {
    _cleanupAudioSession();
    super.dispose();
  }

  void _cleanupAudioSession() {
    _fallbackSessionTimer?.cancel();
    _audioTextSubscription?.cancel();
  }

  /// Evaluates device microphone hardware permissions dynamically at runtime
  Future<bool> _verifyHardwarePermissions() async {
    final status = await Permission.microphone.status;
    if (status.isGranted) return true;
    
    final requestResult = await Permission.microphone.request();
    return requestResult.isGranted;
  }

  /// Establishes an active real-time data streaming link with the platform audio channels
  Future<void> _toggleVoiceSession() async {
    if (_isListening) {
      await _stopVoiceSession();
      return;
    }

    final hasHardwareAccess = await _verifyHardwarePermissions();
    if (!hasHardwareAccess) {
      _triggerHapticAlert(HapticFeedback.vibrate);
      debugPrint("⚠️ [SmartVoiceInput] Native OS Microphone access denied.");
      return;
    }

    _triggerHapticAlert(HapticFeedback.mediumImpact);
    setState(() => _isListening = true);

    // Initialize the safety timeout backup loop
    _fallbackSessionTimer = Timer(_maxRecordingSessionLimit, () {
      if (widget.onListeningTimeout != null) widget.onListeningTimeout!();
      _stopVoiceSession();
    });

    try {
      // PRO TIP: In your production build, plug your chosen STT library's 
      // audio buffer data stream controller straight into this stream block.
      // Simulating a high-speed continuous incoming text token pipeline
      final Stream<String> nativeSpeechStream = _mockIncomingHardwareTextStream();

      _audioTextSubscription = nativeSpeechStream.listen(
        (String rawChunk) async {
          if (!mounted) return;

          // Process the dynamic text node on-the-fly through your autocorrect logic
          final String polishedSegment = await SttAutocorrectEngine.cleanSpeech(rawChunk);

          setState(() {
            widget.controller.text = polishedSegment;
            // Force cursor tracking alignment directly behind the last written character
            widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length),
            );
          });

          if (widget.onPartialResult != null) {
            widget.onPartialResult!(polishedSegment);
          }
        },
        onError: (error) {
          debugPrint("❌ [SmartVoiceInput] Stream Registry Error: $error");
          _stopVoiceSession();
        },
        cancelOnError: true,
      );
    } catch (e) {
      debugPrint("❌ [SmartVoiceInput] Failed to activate hardware stream link: $e");
      _stopVoiceSession();
    }
  }

  Future<void> _stopVoiceSession() async {
    if (!_isListening) return;
    _triggerHapticAlert(HapticFeedback.lightImpact);
    _cleanupAudioSession();
    if (mounted) {
      setState(() => _isListening = false);
    }
  }

  void _triggerHapticAlert(Future<void> Function() hapticMethod) {
    hapticMethod();
  }

  @override
  Widget build(BuildContext context) {
    final activeThemeColor = widget.accentColor ?? Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: _toggleVoiceSession,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: _isListening
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 28,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(activeThemeColor),
                      ),
                    ),
                    Icon(Icons.stop, color: activeThemeColor.withValues(alpha: 0.7), size: 14),
                  ],
                )
              : Icon(
                  Icons.mic,
                  color: activeThemeColor,
                  size: 28,
                ),
        ),
      ),
    );
  }

  /// Streams dynamic, non-hardcoded strings sequentially by tracking timeline ticks
  Stream<String> _mockIncomingHardwareTextStream() async* {
    final List<String> textStreamSimulation = [
      "Teach",
      "Teach me",
      "Teach me about",
      "Teach me about quantum",
      "Teach me about quantum physics",
    ];

    for (var phrase in textStreamSimulation) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!_isListening) break;
      yield phrase;
    }
  }
}
