import 'package:flutter/material.dart';

class PrincipalLiveFeed extends StatelessWidget {
  const PrincipalLiveFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(title: const Text("LIVE: Sunbuilt Academy Activity")),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, i) => ListTile(
          leading: const Icon(Icons.flash_on, color: Colors.greenAccent),
          title: Text("Student ${i+10} just passed Physics Mock", style: const TextStyle(color: Colors.white)),
          subtitle: const Text("2 seconds ago", style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}