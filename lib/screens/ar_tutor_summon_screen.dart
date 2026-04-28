import 'package:flutter/material.dart';
import '../data/character_3d_database.dart';
import '../widgets/ar_character_renderer.dart';

class ArTutorSummonScreen extends StatefulWidget {
  final String characterName;
  const ArTutorSummonScreen({super.key, required this.characterName});

  @override
  State<ArTutorSummonScreen> createState() => _ArTutorSummonScreenState();
}

class _ArTutorSummonScreenState extends State<ArTutorSummonScreen> {
  bool isSpeaking = true; // Simulating active lesson

  @override
  Widget build(BuildContext context) {
    var avatar = Character3dDatabase.avatars[widget.characterName]!;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children:[
          ArCharacterRenderer(
            glbUrl: avatar.glbUrl, 
            isSpeaking: isSpeaking, 
            idleAnim: avatar.idleAnimation, 
            talkAnim: avatar.talkingAnimation
          ),
          const Positioned(top: 50, left: 20, child: BackButton(color: Colors.white)),
          Positioned(
            bottom: 40, left: 20, right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              color: Colors.black87,
              child: Text("${avatar.name}: 'Let us begin today's class.'", style: const TextStyle(color: Colors.cyanAccent, fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}