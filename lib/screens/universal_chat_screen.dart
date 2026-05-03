import 'package:flutter/material.dart';
import '../engines/academic_pivot_engine.dart';
// Incorporates your exact vision: Chat + Media Buttons at top

class UniversalChatScreen extends StatefulWidget {
  final String topic;
  const UniversalChatScreen({super.key, required this.topic});
  @override
  State<UniversalChatScreen> createState() => _UniversalChatScreenState();
}

class _UniversalChatScreenState extends State<UniversalChatScreen> {
  final List<Map<String, String>> messages =[];
  final TextEditingController _ctrl = TextEditingController();

  void _send() {
    String safePrompt = AcademicPivotEngine.sanitizePrompt(_ctrl.text);
    setState(() {
      messages.add({"role": "user", "text": _ctrl.text});
      _ctrl.clear();
      // Mock AI Response
      messages.add({"role": "ai", "text": "Processing $safePrompt..."});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic),
        actions:[
          IconButton(icon: const Icon(Icons.view_in_ar, color: Colors.purpleAccent), onPressed: (){}), // Holo-Deck
          IconButton(icon: const Icon(Icons.movie, color: Colors.blueAccent), onPressed: (){}), // Pexels Video
          IconButton(icon: const Icon(Icons.volume_up, color: Colors.greenAccent), onPressed: (){}), // Voice
        ],
      ),
      body: Column(
        children:[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: messages.length,
              itemBuilder: (ctx, i) => Align(
                alignment: messages[i]['role'] == 'user' ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: messages[i]['role'] == 'user' ? Colors.cyan.withOpacity(0.2) : Colors.white10, borderRadius: BorderRadius.circular(10)),
                  child: Text(messages[i]['text']!),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children:[
                Expanded(child: TextField(controller: _ctrl, decoration: const InputDecoration(hintText: "Ask follow up..."))),
                IconButton(icon: const Icon(Icons.send), onPressed: _send)
              ],
            ),
          )
        ],
      ),
    );
  }
}