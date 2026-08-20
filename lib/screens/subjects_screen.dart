import 'package:flutter/material.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Subjects')),
      body: const Center(
        child: Text(
          'Explore Subjects',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
