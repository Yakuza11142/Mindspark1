import 'package:flutter/material.dart';

class ConfidenceMeterUi extends StatelessWidget {
  final int drillsCompletedToday;
  const ConfidenceMeterUi({super.key, required this.drillsCompletedToday});

  @override
  Widget build(BuildContext context) {
    double confidence = (drillsCompletedToday / 10).clamp(0.0, 1.0); // Max confidence at 10 drills
    Color c = confidence < 0.5 ? Colors.red : (confidence < 0.8 ? Colors.orange : Colors.greenAccent);

    return Column(
      children:[
        const Text("Exam Readiness Level", style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 10),
        Stack(
          children:[
            Container(height: 20, width: double.infinity, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10))),
            FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: confidence,
              child: Container(
                height: 20,
                decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: c.withOpacity(0.5), blurRadius: 10)]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text("${(confidence * 100).toInt()}% Prepared", style: TextStyle(color: c, fontWeight: FontWeight.bold)),
      ],
    );
  }
}