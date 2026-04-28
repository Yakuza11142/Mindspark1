import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../engines/ah_voice_link_engine.dart';
import '../services/mic_permission_gate.dart';
import '../models/ai_persona.dart';
import '../widgets/siri_glow_orb.dart';

class HandsFreeAhScreen extends StatefulWidget {
  final AiPersona persona;
  const HandsFreeAhScreen({super.key, required this.persona});

  @override
  State<HandsFreeAhScreen> createState() => _HandsFreeAhScreenState();
}

class _HandsFreeAhScreenState extends State<HandsFreeAhScreen> {
  String userText = "Tap the orb and speak...";
  String aiText = "";
  bool isListening = false;
  bool isThinking = false;

  void _toggleVoice() async {
    if (isListening) {
      AhVoiceLinkEngine.stopListening();
      setState(() => isListening = false);
      return;
    }

    bool hasMic = await MicPermissionGate.ensureMicAccess();
    if (!hasMic) return;

    setState(() { isListening = true; userText = "Listening..."; aiText = ""; });

    AhVoiceLinkEngine.startListening(
      (heard) => setState(() { userText = heard; isListening = false; isThinking = true; }),
      (reply) => setState(() { aiText = reply; isThinking = false; }),
      widget.persona
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("Call with ${widget.persona.name}"), backgroundColor: Colors.transparent),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          // 1. THE AI RESPONSE
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              isThinking ? "Processing..." : aiText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: widget.persona.themeColor, fontWeight: FontWeight.bold),
            ).animate(target: isThinking ? 1 : 0).fade(duration: 400.ms),
          ),
          
          const Spacer(),

          // 2. THE GLOWING MICROPHONE ORB
          GestureDetector(
            onTap: _toggleVoice,
            child: SiriGlowOrb(isListening: isListening, color: widget.persona.themeColor),
          ),

          const Spacer(),

          // 3. WHAT YOU SAID
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
            child: Text(userText, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 18)),
          )
        ],
      ),
    );
  }
}