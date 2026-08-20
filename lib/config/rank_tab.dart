import 'package:flutter/material.dart';

class RankTab extends StatelessWidget {
  const RankTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rankings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (int i = 0; i < 5; i++)
            ListTile(
              leading: CircleAvatar(child: Text("${i + 1}")),
              title: Text("User ${i + 1}"),
              trailing: Text("${(i + 1) * 1000} XP"),
            ),
        ],
      ),
    );
  }
}
