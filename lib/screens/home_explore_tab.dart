import 'package:flutter/material.dart';
import 'universal_chat_screen.dart';

class HomeExploreTab extends StatelessWidget {
  const HomeExploreTab({super.key});

  final List<Map<String, dynamic>> subjects = const [
    {"name": "Mathematics", "icon": Icons.calculate, "color": Colors.blue},
    {"name": "Physics", "icon": Icons.rocket_launch, "color": Colors.purple},
    {"name": "Chemistry", "icon": Icons.science, "color": Colors.orange},
    {"name": "Biology", "icon": Icons.biotech, "color": Colors.green},
    {"name": "History", "icon": Icons.account_balance, "color": Colors.amber},
    {"name": "Literature", "icon": Icons.book, "color": Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search any topic (Groq/Gemini/OpenAI enabled)...",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: Colors.white10,
                prefixIcon: const Icon(Icons.auto_awesome, color: Colors.cyanAccent),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none),
              ),
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  _launchAI(context, val);
                }
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
              itemCount: subjects.length,
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => _launchAI(context, subjects[i]['name']),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: subjects[i]['color'].withOpacity(0.5))),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(subjects[i]['icon'],
                          size: 40, color: subjects[i]['color']),
                      const SizedBox(height: 10),
                      Text(subjects[i]['name'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchAI(BuildContext context, String topic) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UniversalChatScreen(
          topic: topic,
        ),
      ),
    );
  }
}
