import 'package:flutter/material.dart';
import '../services/history_engine.dart';
import '../services/pdf_service.dart';

class ExamResultScreen extends StatefulWidget {
  final int score, total;
  final String examName;
  const ExamResultScreen({super.key, required this.score, required this.total, required this.examName});

  @override
  State<ExamResultScreen> createState() => _ExamResultScreenState();
}

class _ExamResultScreenState extends State<ExamResultScreen> {
  @override
  void initState() {
    super.initState();
    int percentage = ((widget.score / widget.total) * 100).round();
    HistoryEngine.saveResult(examType: widget.examName, score: percentage);
  }

  @override
  Widget build(BuildContext context) {
    int percentage = ((widget.score / widget.total) * 100).round();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Exam Complete", style: TextStyle(fontSize: 30)),
            Text("$percentage%", style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: percentage > 50 ? Colors.green : Colors.red)),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Return Home"),
            ),
            TextButton(
              onPressed: () => PdfService.sendReportCard("parent@email.com", "Student", percentage),
              child: const Text("Email Report Card"),
            )
          ],
        ),
      ),
    );
  }
}