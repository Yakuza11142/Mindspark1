import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../config/secrets.dart';

class PlagiarismChecker extends StatefulWidget {
  const PlagiarismChecker({super.key});
  @override
  State<PlagiarismChecker> createState() => _PlagiarismCheckerState();
}

class _PlagiarismCheckerState extends State<PlagiarismChecker> {
  final TextEditingController _ctrl = TextEditingController();
  String result = "";

  void _check() async {
    final model = GenerativeModel(model: 'gemini-pro', apiKey: Secrets.geminiKey);
    final res = await model.generateContent([
      Content.text("Analyze this text for AI generation or plagiarism probability: '${_ctrl.text}'. Keep it short.")
    ]);
    setState(() => result = res.text ?? "Analysis failed.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Originality Check")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _ctrl, maxLines: 5, decoration: const InputDecoration(hintText: "Paste essay here...")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _check, child: const Text("Analyze")),
            const SizedBox(height: 20),
            Text(result, style: const TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}