import 'package:flutter/material.dart';

class SubjectCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  final List<String> subtopics;

  SubjectCategory({required this.id, required this.name, required this.icon, required this.color, required this.subtopics});
}