import 'package:flutter/material.dart';
import '../engines/mindspark_core.dart';
import '../widgets/groq_speed_metric.dart';
import '../widgets/holo_deck_trigger_button.dart';

class LessonScreenGroq extends StatefulWidget {
  final String topic;
  final bool isPro;
  const LessonScreenGroq({super.key, required this.topic, required this.isPro});

  @override
  State<LessonScreenGroq> createState() => _LessonScreenGroqState();
}

class _LessonScreenGroqState extends State<LessonScreenGroq> {
  String? lessonText;
  int generationTime = 0;

  @override
  void initState() {
    super.initState();
    MindsparkCore.generateLesson(widget.topic, widget.isPro, false).then((res) {
      if (mounted) setState(() {
        lessonText = res['text'];
        generationTime = res['time_ms'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: Text(widget.topic), backgroundColor: Colors.black),
      body: Column(
        children:[
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: lessonText == null 
                  ? const Center(child: CircularProgressIndicator(color: Colors.cyanAccent))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        GroqSpeedMetric(timeMs: generationTime, isPro: widget.isPro),
                        const SizedBox(height: 20),
                        Text(lessonText!, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.6)),
                      ],
                    ),
            ),
          ),
          // AR and Audio are now optional buttons to save you money
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                IconButton(icon: const Icon(Icons.volume_up, color: Colors.cyanAccent), onPressed: () {}),
                HoloDeckTriggerButton(isPro: widget.isPro, onTrigger: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }
}