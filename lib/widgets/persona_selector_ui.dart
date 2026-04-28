import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/persona_database.dart';
import '../services/active_persona_manager.dart';

class PersonaSelectorUi extends StatelessWidget {
  const PersonaSelectorUi({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = context.watch<ActivePersonaManager>();

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: PersonaDatabase.characters.length,
        itemBuilder: (ctx, i) {
          final persona = PersonaDatabase.characters[i];
          final isSelected = manager.currentPersona.id == persona.id;

          return GestureDetector(
            onTap: () {
              context.read<ActivePersonaManager>().setPersona(persona);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${persona.name} Selected!"), backgroundColor: persona.themeColor, duration: const Duration(seconds: 1)));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 110,
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: isSelected ? persona.themeColor.withOpacity(0.2) : Colors.white10,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: isSelected ? persona.themeColor : Colors.transparent, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Icon(persona.avatarIcon, size: 40, color: isSelected ? persona.themeColor : Colors.grey),
                  const SizedBox(height: 10),
                  Text(persona.name, style: TextStyle(color: isSelected ? Colors.white : Colors.grey, fontWeight: FontWeight.bold)),
                  Text(persona.title, style: TextStyle(color: isSelected ? persona.themeColor : Colors.grey, fontSize: 10)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}