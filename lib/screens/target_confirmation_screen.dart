import 'package:flutter/material.dart';
import '../models/dynamic_exam_model.dart';
import '../main_layout_screen.dart';

class TargetConfirmationScreen extends StatelessWidget {
  final DynamicExamModel exam;
  const TargetConfirmationScreen({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              Text("Target Acquired: ${exam.name}", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Text("Max Score: ${exam.maxScore}"),
              Text("Subjects: ${exam.subjects.join(', ')}"),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainLayoutScreen())),
                child: const Text("Lock In & Start")
              )
            ],
          ),
        ),
      ),
    );
  }
}