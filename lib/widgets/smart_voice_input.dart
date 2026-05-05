import 'package:flutter/material.dart';
import '../engines/stt_autocorrect_engine.dart';

/// A global, infinite-use voice input widget. 
/// Removed FlutLab dependencies to use standard Flutter components.
class SmartVoiceInput extends StatefulWidget {
  final TextEditingController controller;
  final Color? accentColor;

  const SmartVoiceInput({
    super.key, 
    required this.controller, 
    this.accentColor,
  });

  @override
  State<SmartVoiceInput> createState() => _SmartVoiceInputState();
}

class _SmartVoiceInputState extends State<SmartVoiceInput> {
  bool isListening = false;

  /// Triggered on every tap for infinite reuse
  Future<void> _triggerVoice() async {
    if (isListening) return;

    setState(() => isListening = true);

    try {
      // Replace this string with your actual live STT stream/package result
      String rawAudioText = "Teache me abot fizzix"; 

      // Process through your global engine
      String polishedText = await SttAutocorrectEngine.cleanSpeech(rawAudioText);

      // Updates the controller text immediately
      widget.controller.text = polishedText;
      
      // Move cursor to the end of the new text
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: widget.controller.text.length),
      );
    } catch (e) {
      debugPrint("STT Error: $e");
    } finally {
      // Ensures the widget resets so it can be tapped again infinitely
      if (mounted) {
        setState(() => isListening = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _triggerVoice,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: isListening
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.accentColor ?? Theme.of(context).primaryColor,
                  ),
                ),
              )
            : Icon(
                Icons.mic,
                color: widget.accentColor ?? Theme.of(context).primaryColor,
                size: 28,
              ),
      ),
    );
  }
}
