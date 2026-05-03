import 'package:flutter/material.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Knowledge")),
      body: ListView(
        children: const[
          ListTile(leading: Icon(Icons.bookmark, color: Colors.cyan), title: Text("Quantum Physics Chat")),
          ListTile(leading: Icon(Icons.picture_as_pdf, color: Colors.red), title: Text("My JAMB Certificate")),
        ],
      ),
    );
  }
}