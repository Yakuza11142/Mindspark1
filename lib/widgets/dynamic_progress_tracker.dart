import 'package:flutter/material.dart';
import '../models/dynamic_exam_model.dart';

class DynamicProgressTracker extends StatelessWidget {
  final DynamicExamModel exam;
  final int completedSubjects;
  const DynamicProgressTracker({super.key, required this.exam, required this.completedSubjects});

  @override
  Widget build(BuildContext context) {
    double progress = completedSubjects / exam.subjects.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Text("${exam.name} Syllabus Progress", style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 5),
        LinearProgressIndicator(value: progress, color: Colors.amber, backgroundColor: Colors.white10, minHeight: 8),
      ],
    );
  }
}