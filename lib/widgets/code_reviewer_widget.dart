import 'package:flutter/material.dart';

class CodeReviewerWidget extends StatefulWidget {
  const CodeReviewerWidget({super.key});
  @override
  State<CodeReviewerWidget> createState() => _CodeReviewerWidgetState();
}

class _CodeReviewerWidgetState extends State<CodeReviewerWidget> {
  final TextEditingController _codeCtrl = TextEditingController();
  String feedback = "";

  void _analyze() async {
    // Send _codeCtrl.text to Gemini with prompt "Find bugs in this code"
    setState(() => feedback = "Looking good! Consider optimizing loop...");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: _codeCtrl, maxLines: 5, decoration: const InputDecoration(hintText: "Paste code here")),
        ElevatedButton(onPressed: _analyze, child: const Text("Debug with AI")),
        if (feedback.isNotEmpty) Text(feedback, style: const TextStyle(color: Colors.greenAccent)),
      ],
    );
  }
}