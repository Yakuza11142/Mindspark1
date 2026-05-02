import 'package:flutter/material.dart';

class OfflineResultCard extends StatelessWidget {
  final String result;
  const OfflineResultCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blueGrey[900], borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.cyan)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          const Row(children:[Icon(Icons.offline_bolt, color: Colors.amber), SizedBox(width: 10), Text("INSTANT OFFLINE RESULT", style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 10))]),
          const SizedBox(height: 10),
          Text(result, style: const TextStyle(color: Colors.white, fontSize: 18, height: 1.5)),
        ],
      ),
    );
  }
}