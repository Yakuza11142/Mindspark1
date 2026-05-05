import 'package:flutter/material.dart';
import '../engines/ai_fusion_core.dart';
import '../widgets/holo_deck_trigger_button.dart';
import '../widgets/tts_stt_control_bar.dart';

class LessonScreenRefined extends StatefulWidget {
  final String topic;
  final bool isPro;
  const LessonScreenRefined({super.key, required this.topic, required this.isPro});

  @override
  State<LessonScreenRefined> createState() => _LessonScreenRefinedState();
}

class _LessonScreenRefinedState extends State<LessonScreenRefined> {
  String? lessonText;
  bool isHoloActive = false;

  @override
  void initState() {
    super.initState();
    AiFusionCore.generatePerfectLesson(widget.topic, widget.isPro).then((res) {
      if (mounted) setState(() => lessonText = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: Text(widget.topic), backgroundColor: Colors.black),
      body: Column(
        children:[
          // THE HOLO-DECK DISPLAY (Hidden until requested)
          if (isHoloActive)
            Container(
              height: 300,
              color: Colors.black,
              child: const Center(child: Text("3D AR Model Rendering...", style: TextStyle(color: Colors.cyan))), // Tripo Logic goes here
            ),
          
          // THE LESSON TEXT (Loads instantly)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: lessonText == null 
                  ? const Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
                  : Text(lessonText!, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5)),
            ),
          ),
          
          // THE OPTIONAL CONTROLS
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                TtsSttControlBar(textToRead: lessonText ?? "", isPro: widget.isPro),
                HoloDeckTriggerButton(
                  isPro: widget.isPro, 
                  onTrigger: () => setState(() => isHoloActive = true)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}