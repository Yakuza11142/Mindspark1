import 'package:flutter/material.dart';
import '../engines/two_way_voice_engine.dart';

class HandsFreeDeskMode extends StatefulWidget {
  final String persona;
  final bool isPro;
  const HandsFreeDeskMode({super.key, required this.persona, required this.isPro});

  @override
  State<HandsFreeDeskMode> createState() => _HandsFreeDeskModeState();
}

class _HandsFreeDeskModeState extends State<HandsFreeDeskMode> {
  @override
  void initState() {
    super.initState();
    TwoWayVoiceEngine.startConversation(widget.persona, widget.isPro);
  }

  @override
  void dispose() {
    TwoWayVoiceEngine.endConversation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.record_voice_over, size: 100, color: Colors.cyanAccent),
            const SizedBox(height: 30),
            Text("Talking to ${widget.persona}...", style: const TextStyle(color: Colors.white, fontSize: 24)),
            const SizedBox(height: 20),
            const Text("Put your phone down. Just speak.", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () => Navigator.pop(context), 
              child: const Text("END CALL", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            )
          ],
        ),
      ),
    );
  }
}