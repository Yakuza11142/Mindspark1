import 'package:flutter/material.dart';

class DailyRewardsScreen extends StatelessWidget {
  const DailyRewardsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daily Login")),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: 7,
        itemBuilder: (ctx, i) => Card(
          color: i == 0 ? Colors.green : Colors.grey, // Mock logic for "Today"
          child: Center(child: Text("Day ${i+1}")),
        ),
      ),
    );
  }
}