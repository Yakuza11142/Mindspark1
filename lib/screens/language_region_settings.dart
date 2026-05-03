import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalLanguageSettings extends StatefulWidget {
  // Pass any language map here (African, European, Asian, etc.)
  final Map<String, String> languageMap; 
  final String title;

  const GlobalLanguageSettings({
    super.key, 
    this.languageMap = const {
      "en": "English",
      "yo": "Yoruba",
      "sw": "Swahili",
      "fr": "French",
      "es": "Spanish",
      "zh": "Mandarin",
    },
    this.title = "Select Language",
  });

  @override
  State<GlobalLanguageSettings> createState() => _GlobalLanguageSettingsState();
}

class _GlobalLanguageSettingsState extends State<GlobalLanguageSettings> {
  String _selectedCode = "en";

  @override
  void initState() {
    super.initState();
    _loadLang();
  }

  void _loadLang() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _selectedCode = prefs.getString('global_language_code') ?? "en");
  }

  void _saveLang(String code, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('global_language_code', code);
    setState(() => _selectedCode = code);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Language set to $name"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Convert map to list for the builder
    final keys = widget.languageMap.keys.toList();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: keys.length,
        itemBuilder: (ctx, i) {
          final code = keys[i];
          final name = widget.languageMap[code]!;
          
          return ListTile(
            title: Text(name, style: const TextStyle(color: Colors.white)),
            trailing: _selectedCode == code 
                ? const Icon(Icons.check_circle, color: Colors.cyanAccent) 
                : null,
            onTap: () => _saveLang(code, name),
          );
        },
      ),
    );
  }
}
