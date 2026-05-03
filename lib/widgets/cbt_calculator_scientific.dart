import 'package:flutter/material.dart';

class CbtCalculatorScientific extends StatelessWidget {
  const CbtCalculatorScientific({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.black87,
      child: Column(
        children: [
          const Text("SCIENTIFIC ENGINE [ACTIVE]", style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.cyan),
          // Infinite Calculation History
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("Calculation #$index", style: const TextStyle(color: Colors.white70)),
                  subtitle: const Text("f(x) = sin(θ) + log(n)", style: TextStyle(color: Colors.cyanAccent)),
                  trailing: const Icon(Icons.history, color: Colors.cyan, size: 14),
                );
              },
            ),
          ),
          // Floating Holographic Input Simulation
          const TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Enter Equation...",
              hintStyle: TextStyle(color: Colors.white24),
              prefixIcon: Icon(Icons.calculate, color: Colors.cyan),
            ),
          ),
        ],
      ),
    );
  }
}
