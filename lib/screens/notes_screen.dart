import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesScreen extends StatefulWidget {
  final String topic;
  const NotesScreen({super.key, required this.topic});
  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  void _loadNote() async {
    final prefs = await SharedPreferences.getInstance();
    _ctrl.text = prefs.getString('note_${widget.topic}') ?? "";
  }

  void _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('note_${widget.topic}', _ctrl.text);
    if(mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Note Saved")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes: ${widget.topic}"), actions: [
        IconButton(icon: const Icon(Icons.save), onPressed: _save)
      ]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: _ctrl,
          maxLines: null,
          expands: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Jot down key points here...",
            border: InputBorder.none
          ),
        ),
      ),
    );
  }
}