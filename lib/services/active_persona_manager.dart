import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/persona_database.dart';
import '../models/ai_persona.dart';

class ActivePersonaManager extends ChangeNotifier {
  AiPersona _currentPersona = PersonaDatabase.characters[0]; // Default to Spark

  AiPersona get currentPersona => _currentPersona;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedId = prefs.getString('selected_persona_id');
    if (savedId != null) {
      _currentPersona = PersonaDatabase.characters.firstWhere((p) => p.id == savedId, orElse: () => PersonaDatabase.characters[0]);
      notifyListeners();
    }
  }

  Future<void> setPersona(AiPersona persona) async {
    _currentPersona = persona;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_persona_id', persona.id);
  }
}