import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../engines/brain_service.dart'; // Reuse brain
import 'package:provider/provider.dart';

class DebateArenaScreen extends StatefulWidget {
  final String topic; // e.g. "Climate Change"
  const DebateArenaScreen({super.key, required this.topic});
  @override
  State<DebateArenaScreen> createState() => _DebateArenaScreenState();
}

class _DebateArenaScreenState extends State<DebateArenaScreen> {
  final ChatUser _user = ChatUser(id: '1');
  final ChatUser _ai = ChatUser(id: '2', firstName: 'Devil\'s Advocate');
  List<ChatMessage> _msgs = [];

  @override
  void initState() {
    super.initState();
    _msgs.add(ChatMessage(
      text: "I disagree with the premise of ${widget.topic}. Prove me wrong.",
      user: _ai, createdAt: DateTime.now()
    ));
  }

  void _handleSend(ChatMessage m) async {
    setState(() => _msgs.insert(0, m));
    // Prompt injection: "Argue against the user."
    // Implementation uses BrainService with custom prompt
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Debate Arena ⚔️")),
      body: DashChat(currentUser: _user, onSend: _handleSend, messages: _msgs),
    );
  }
}