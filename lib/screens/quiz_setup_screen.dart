import 'package:flutter/material.dart';
import '../services/quiz_category_service.dart';
import 'quiz_screen.dart'; // Script 16 (Updated logic needed to accept args)

class QuizSetupScreen extends StatefulWidget {
  const QuizSetupScreen({super.key});
  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreenState();
}

class _QuizSetupScreenState extends State<QuizSetupScreen> {
  List<Map<String, dynamic>> categories = [];
  int? selectedId;
  String difficulty = "medium";

  @override
  void initState() {
    super.initState();
    QuizCategoryService.getCategories().then((c) => setState(() => categories = c));
  }

  void _start() {
    if (selectedId == null) return;
    // Construct the specific API URL
    String apiUrl = "https://opentdb.com/api.php?amount=10&category=$selectedId&difficulty=$difficulty&type=multiple";
    
    // Navigate to Quiz Screen with this specific URL
    Navigator.push(context, MaterialPageRoute(builder: (_) => QuizScreen(apiUrl: apiUrl)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configure Quiz")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Select Topic:", style: TextStyle(fontSize: 18, color: Colors.cyan)),
            DropdownButton<int>(
              value: selectedId,
              hint: const Text("Choose Category", style: TextStyle(color: Colors.white)),
              dropdownColor: Colors.grey[900],
              items: categories.map((c) => DropdownMenuItem<int>(
                value: c['id'], 
                child: Text(c['name'], style: const TextStyle(color: Colors.white))
              )).toList(),
              onChanged: (v) => setState(() => selectedId = v),
            ),
            const SizedBox(height: 20),
            const Text("Difficulty:", style: TextStyle(fontSize: 18, color: Colors.amber)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ["easy", "medium", "hard"].map((d) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActionChip(
                  label: Text(d.toUpperCase()),
                  backgroundColor: difficulty == d ? Colors.blue : Colors.white10,
                  onPressed: () => setState(() => difficulty = d),
                ),
              )).toList(),
            ),
            const Spacer(),
            ElevatedButton(onPressed: _start, child: const Text("START QUIZ"))
          ],
        ),
      ),
    );
  }
}