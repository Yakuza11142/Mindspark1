import 'package:flutter/material.dart';
import '../../engines/brain_service.dart';
import '../../engines/mnemonics_generator_prompt.dart';

class MnemonicsScreen extends StatefulWidget {
  final String topic;
  const MnemonicsScreen({super.key, required this.topic});

  @override
  State<MnemonicsScreen> createState() => _MnemonicsScreenState();
}

class _MnemonicsScreenState extends State<MnemonicsScreen> {
  String? _trick;

  @override
  void initState() {
    super.initState();
    String prompt = MnemonicsGeneratorPrompt.inject(widget.topic);
    BrainService().generateLesson(prompt, true, false).then((res) {
      if (mounted) setState(() => _trick = res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Memory Tricks 🧠")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _trick == null
              ? const CircularProgressIndicator(color: Colors.cyan)
              : Text(_trick!, style: const TextStyle(fontSize: 24, color: Colors.amber, height: 1.5)),
        ),
      ),
    );
  }
}