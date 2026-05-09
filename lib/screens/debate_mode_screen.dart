import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import '../services/brain_service.dart';
import 'package:provider/provider.dart';

class DebateModeScreen extends StatefulWidget {
  final String topic;
  const DebateModeScreen({super.key, required this.topic});
  @override
  State<DebateModeScreen> createState() => _DebateModeScreenState();
}

class _DebateModeScreenState extends State<DebateModeScreen> {
  // Chat Logic but prompt is set to "Disagree with user and force them to prove points"
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Debate: ${widget.topic}")),
      body: const Center(child: Text("Debate UI Loading...")),
    );
  }
}