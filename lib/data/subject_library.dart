import 'package:flutter/material.dart';
import '../models/subject_category_model.dart';

class SubjectLibrary {
  static List<SubjectCategory> getCategories() {
    return[
      SubjectCategory(id: 'sci', name: 'Science & Space', icon: Icons.rocket_launch, color: Colors.purple, subtopics:['Physics', 'Astronomy', 'Chemistry']),
      SubjectCategory(id: 'math', name: 'Mathematics', icon: Icons.calculate, color: Colors.blue, subtopics: ['Algebra', 'Calculus', 'Geometry']),
      SubjectCategory(id: 'tech', name: 'Technology', icon: Icons.computer, color: Colors.cyan, subtopics: ['Coding', 'AI', 'Robotics']),
      SubjectCategory(id: 'hist', name: 'History', icon: Icons.account_balance, color: Colors.amber, subtopics: ['World War II', 'African History', 'Ancient Rome']),
    ];
  }
}