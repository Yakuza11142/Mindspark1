import 'package:flutter/material.dart';
import '../engines/audio_director_engine.dart'; // The new sound script
// ... other imports (ModelViewer, VideoPlayer, etc.)

class OmniSenseCinemaV2 extends StatefulWidget {
  final String topic;
  const OmniSenseCinemaV2({super.key, required this.topic});

  @override
  State<OmniSenseCinemaV2> createState() => _OmniSenseCinemaV2State();
}

class _OmniSenseCinemaV2State extends State<OmniSenseCinemaV2> {
  
  @override
  void initState() {
    super.initState();
    // 🎵 THE MAGIC: As soon as the screen opens, the soundscape begins
    AudioDirectorEngine.playAtmosphere(widget.topic);
  }

  @override
  void dispose() {
    // 🛑 Stop the sound when they leave the lesson
    AudioDirectorEngine.stopAtmosphere();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children:[
          // 1. Runway 4K Video Background
          // 2. Tripo ARCore Hologram
          // 3. HeyGen Teacher
          const Center(child: Text("Holo-Deck Active", style: TextStyle(color: Colors.cyanAccent))),
        ],
      ),
    );
  }
}