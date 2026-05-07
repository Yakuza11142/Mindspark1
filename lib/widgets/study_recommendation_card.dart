import 'package:flutter/material.dart';
import '../services/weakness_detector.dart';

class StudyRecommendationCard extends StatelessWidget {
  const StudyRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    String advice = WeaknessDetector.analyze([]);
    return Card(
      color: Colors.orange.withOpacity(0.2),
      child: ListTile(
        leading: const Icon(Icons.warning, color: Colors.orange),
        title: const Text("AI Recommendation", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
        subtitle: Text(advice, style: const TextStyle(color: Colors.white)),
        trailing: ElevatedButton(onPressed: (){}, child: const Text("Review")),
      ),
    );
  }
}