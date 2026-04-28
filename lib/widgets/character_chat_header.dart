import 'package:flutter/material.dart';
import '../models/ai_persona.dart';

class CharacterChatHeader extends StatelessWidget {
  final AiPersona persona;
  const CharacterChatHeader({super.key, required this.persona});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: persona.themeColor.withOpacity(0.1), border: Border(bottom: BorderSide(color: persona.themeColor))),
      child: Row(
        children:[
          CircleAvatar(backgroundColor: persona.themeColor, child: Icon(persona.avatarIcon, color: Colors.black)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text(persona.name, style: TextStyle(color: persona.themeColor, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(persona.title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          const Spacer(),
          const Icon(Icons.verified, color: Colors.blue) // Trust badge
        ],
      ),
    );
  }
}