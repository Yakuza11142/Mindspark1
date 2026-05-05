import 'package:flutter/material.dart';
import '../widgets/learning_curve_chart.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Brain Analytics")),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          // This creates a list of analytics segments
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Segment ${index + 1}: Focus Time 12h 30m",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const LearningCurveChart(),
              const Divider(height: 60, thickness: 2), // Separator for feel
            ],
          );
        },
      ),
    );
  }
}
