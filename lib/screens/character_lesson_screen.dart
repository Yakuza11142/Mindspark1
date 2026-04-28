import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../engines/omni_lingual_translator.dart';
import '../engines/avatar_video_controller.dart';
import '../services/audio_service.dart';
import '../data/persona_database.dart';

class CharacterLessonScreen extends StatefulWidget {
  final String topic;
  final String language;
  final String characterId; // 'spark_main'

  const CharacterLessonScreen({super.key, required this.topic, required this.language, required this.characterId});

  @override
  State<CharacterLessonScreen> createState() => _CharacterLessonScreenState();
}

class _CharacterLessonScreenState extends State<CharacterLessonScreen> {
  late VideoPlayerController _avatarCtrl;
  String? textContent;
  final AudioService _audio = AudioService();

  @override
  void initState() {
    super.initState();
    var persona = PersonaDatabase.characters.firstWhere((p) => p.id == widget.characterId);
    
    // 1. Initialize the Video Avatar (Blinks, breathes)
    _avatarCtrl = AvatarVideoController.getController(persona.name);
    _avatarCtrl.setLooping(true);
    _avatarCtrl.play();

    // 2. Generate the translated text
    _loadLesson(persona.systemPrompt);
  }

  void _loadLesson(String prompt) async {
    String text = await OmniLingualTranslator.generateInLanguage(widget.topic, widget.language, prompt);
    
    // 3. Play the Audio
    await _audio.speak(text); // Ensure ElevenLabs supports the target language!
    
    if (mounted) setState(() => textContent = text);
  }

  @override
  void dispose() {
    _avatarCtrl.dispose();
    _audio.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: Text(widget.topic), backgroundColor: Colors.transparent),
      body: Stack(
        children:[
          // TEXT CONTENT
          Padding(
            padding: const EdgeInsets.all(20),
            child: textContent == null 
              ? const Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
              : SingleChildScrollView(child: Text(textContent!, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.5))),
          ),

          // THE AI AVATAR (Bottom Right Corner)
          Positioned(
            bottom: 20, right: 20,
            width: 150, height: 200,
            child: _avatarCtrl.value.isInitialized
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    // Video player background is transparent, showing the app behind it
                    child: VideoPlayer(_avatarCtrl),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}