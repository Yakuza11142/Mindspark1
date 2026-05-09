import 'package:flutter/material.dart';

class PeriodicElement extends StatelessWidget {
  final String symbol;
  final String name;
  final int number;
  final Color color;

  const PeriodicElement({super.key, required this.symbol, required this.name, required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, height: 80,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("$number", style: const TextStyle(fontSize: 10, color: Colors.black54)),
          Text(symbol, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
          Text(name, style: const TextStyle(fontSize: 10, color: Colors.black)),
        ],
      ),
    );
  }
}