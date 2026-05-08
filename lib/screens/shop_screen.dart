import 'package:flutter/material.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Spark Shop")),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _item("Streak Freeze", "500 ⚡", Icons.ac_unit),
          _item("Heart Refill", "200 ⚡", Icons.favorite),
          _item("X-Ray Pass", "1000 ⚡", Icons.layers),
          _item("Double XP", "300 ⚡", Icons.bolt),
        ],
      ),
    );
  }

  Widget _item(String title, String cost, IconData icon) {
    return Card(
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.cyan),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(cost, style: const TextStyle(color: Colors.amber)),
        ],
      ),
    );
  }
}