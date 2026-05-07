import 'package:flutter/material.dart';
import '../engines/essay_grader_advanced.dart';

class EssayGraderScreen extends StatefulWidget {
  const EssayGraderScreen({super.key});
  @override
  State<EssayGraderScreen> createState() => _EssayGraderScreenState();
}

class _EssayGraderScreenState extends State<EssayGraderScreen> {
  final TextEditingController _ctrl = TextEditingController();
  Map<String, dynamic>? results;
  bool loading = false;

  void _grade() async {
    setState(() => loading = true);
    var res = await EssayGraderAdvanced.gradeEssay(_ctrl.text);
    setState(() { results = res; loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Essay Grader")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:[
            Expanded(child: TextField(controller: _ctrl, maxLines: null, expands: true, decoration: const InputDecoration(hintText: "Paste essay..."))),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: _grade, child: const Text("Grade My Work")),
            if (loading) const CircularProgressIndicator(),
            if (results != null) ...[
              const Divider(),
              Text("Grammar: ${results!['grammar']}/100", style: const TextStyle(color: Colors.green)),
              Text("Content: ${results!['content']}/100", style: const TextStyle(color: Colors.blue)),
              Text("Feedback: ${results!['feedback']}"),
            ]
          ],
        ),
      ),
    );
  }
}