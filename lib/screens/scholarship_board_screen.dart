import 'package:flutter/material.dart';

class ScholarshipBoardScreen extends StatelessWidget {
  const ScholarshipBoardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Scholarship Matches 🎓")),
      body: ListView(
        children: const[
          ListTile(leading: Icon(Icons.monetization_on, color: Colors.green), title: Text("MTN Foundation (₦200k/yr)")),
        ],
      ),
    );
  }
}