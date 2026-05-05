import 'package:flutter/material.dart';

class SpecimenCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const SpecimenCard({
    super.key,
    required this.title,
    required this.description,
    this.icon = Icons.bug_report,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Makes it span the screen
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12), // Cleaner look
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 80, color: Colors.greenAccent),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter Phylum/Class...",
              hintStyle: const TextStyle(color: Colors.white24),
              filled: true,
              fillColor: Colors.black26,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
