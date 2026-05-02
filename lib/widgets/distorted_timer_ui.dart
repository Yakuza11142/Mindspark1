import 'package:flutter/material.dart';
import '../services/exam_time_distorter.dart';

class DistortedTimerUi extends StatelessWidget {
  final int realSecondsLeft;
  const DistortedTimerUi({super.key, required this.realSecondsLeft});

  @override
  Widget build(BuildContext context) {
    int displayedSeconds = ExamTimeDistorter.applyDistortion(realSecondsLeft);
    int m = displayedSeconds ~/ 60;
    int s = displayedSeconds % 60;
    
    return Text(
      "${m.toString().padLeft(2,'0')}:${s.toString().padLeft(2,'0')}",
      style: const TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
    );
  }
}