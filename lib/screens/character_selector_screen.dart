import 'package:flutter/material.dart';
import '../data/persona_database.dart';
import 'character_lesson_screen.dart';
import '../widgets/language_dropdown.dart';

class CharacterSelectorScreen extends StatefulWidget {
  final String topic;
  const CharacterSelectorScreen({super.key, required this.topic});

  @override
  State<CharacterSelectorScreen> createState() => _CharacterSelectorScreenState();
}

class _CharacterSelectorScreenState extends State<CharacterSelectorScreen> {
  String selectedLang = "English";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Select Tutor & Language")),
      body: Column(
        children:[
          const SizedBox(height: 20),
          LanguageDropdown(onSelect: (l) => setState(() => selectedLang = l)),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: PersonaDatabase.characters.length,
              itemBuilder: (ctx, i) {
                var p = PersonaDatabase.characters[i];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: p.themeColor, child: Icon(p.avatarIcon)),
                  title: Text(p.name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(p.title, style: TextStyle(color: p.themeColor)),
                  trailing: const Icon(Icons.play_arrow, color: Colors.cyan),
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CharacterLessonScreen(topic: widget.topic, language: selectedLang, characterId: p.id))),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}