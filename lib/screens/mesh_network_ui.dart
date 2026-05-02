import 'package:flutter/material.dart';

class MeshNetworkUi extends StatelessWidget {
  const MeshNetworkUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Classroom Mesh Network")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.radar, size: 100, color: Colors.cyanAccent),
            const SizedBox(height: 20),
            const Text("Scanning for nearby students...", style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 40),
            ListTile(leading: const CircleAvatar(backgroundColor: Colors.green), title: const Text("Node: Ahmed's Device"), subtitle: const Text("Signal: Strong"), trailing: ElevatedButton(onPressed: (){}, child: const Text("Connect"))),
          ],
        ),
      ),
    );
  }
}