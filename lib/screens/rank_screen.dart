import 'package:flutter/material.dart';

class RankScreen extends StatelessWidget {
  const RankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rank Leaderboard')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Text('1')),
            title: Text('Top Student'),
            subtitle: Text('2500 XP'),
          ),
          ListTile(
            leading: CircleAvatar(child: Text('2')),
            title: Text('You'),
            subtitle: Text('1250 XP'),
          ),
        ],
      ),
    );
  }
}
