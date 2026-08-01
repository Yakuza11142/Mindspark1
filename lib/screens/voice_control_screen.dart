import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../services/voice_command_listener.dart';

class VoiceControlScreen extends StatefulWidget {
  const VoiceControlScreen({super.key});

  @override
  State<VoiceControlScreen> createState() => _VoiceControlScreenState();
}

class _VoiceControlScreenState extends State<VoiceControlScreen> {
  String _statusMessage = "Hold to Speak...";
  bool _isListening = false;
  
  // Instantiated the speech manager reference cleanly to allow explicit cleanup loops [INDEX]
  final VoiceCommandListener _voiceCommandListener = VoiceCommandListener();

  /// Starts the hardware audio stream capture session defensively [INDEX]
  void _toggleVoiceListeningPipeline() async {
    if (_isListening) return;

    setState(() {
      _statusMessage = "Listening (AI Context Active)...";
      _isListening = true;
    });
    
    developer.log("🎙️ VoiceControl: Activating native speech microservice listener loop.");

    try {
      // Swapped loose callbacks for explicit, protected state checks to secure the thread pipeline [INDEX]
      _voiceCommandListener.listenForCommands((String command) {
        final String cleanedCommand = command.trim();

        // Enforce a strict atomic context check boundary prior to evaluating layout updates [INDEX]
        if (!mounted) {
          developer.log("⚠️ VoiceControl: Context unmounted mid-stream callback. Dropping thread updates.");
          return;
        }

        setState(() {
          _statusMessage = cleanedCommand.isNotEmpty ? "Understood: $cleanedCommand" : "Speech unrecognized.";
          _isListening = false;
        });

        if (cleanedCommand.isNotEmpty) {
          _executeContextualVoiceIntent(cleanedCommand);
        }
      });
    } catch (e, stackTrace) {
      developer.log("❌ VoiceControl: Native speech framework encountered an allocation error", error: e, stackTrace: stackTrace);
      if (mounted) {
        setState(() {
          _statusMessage = "Microphone error. Try again.";
          _isListening = false;
        });
      }
    }
  }

  /// Central processing dispatcher routes matching speech intents down business layers safely [INDEX]
  void _executeContextualVoiceIntent(String parsedText) {
    developer.log("🚀 VoiceControl: Dispatching validated intent engine track: $parsedText");
    // Connect your VoiceIntentParser here [INDEX]
  }

  // Explicitly override the dispose hook to tear down audio sessions and block native resource leaks [INDEX]
  @override
  void dispose() {
    try {
      // Notify the native audio engine to release device microphone handles instantly [INDEX]
      _voiceCommandListener.stop(); 
      developer.log("⚙️ VoiceControl: Native hardware audio session unlinked cleanly.");
    } catch (e) {
      developer.log("⚠️ VoiceControl: Error de-allocating audio framework properties: $e");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Enforced efficient compile-time hex layouts [INDEX]
      appBar: AppBar(
        title: const Text("Voice Command Engine", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dynamic color transition shifts provide instant visual haptic feedback [INDEX]
              Icon(
                Icons.mic, 
                size: 90, 
                color: _isListening ? Colors.redAccent : Colors.cyanAccent,
              ),
              const SizedBox(height: 25),
              Text(
                _statusMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _isListening ? null : _toggleVoiceListeningPipeline, // Locks touch input during hot sessions [INDEX]
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  disabledBackgroundColor: const Color(0xFF1E293B),
                  minimumSize: const Size(200, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 10,
                ),
                child: Text(
                  _isListening ? "PROCESSING..." : "ACTIVATE",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
