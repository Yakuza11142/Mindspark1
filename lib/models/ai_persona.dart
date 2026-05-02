import 'package:flutter/material.dart';

class AiPersona {
  final String id;
  final String name;
  final String title;
  final String systemPrompt;
  final String greeting;
  final Color themeColor;
  final IconData avatarIcon;

  AiPersona({
    required this.id,
    required this.name,
    required this.title,
    required this.systemPrompt,
    required this.greeting,
    required this.themeColor,
    required this.avatarIcon,
  });
}