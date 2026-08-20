import 'package:flutter/material.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Library")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            title: Text("Saved Lessons"),
            subtitle: Text("5 lessons"),
          ),
          ListTile(
            title: Text("Bookmarks"),
            subtitle: Text("12 items"),
          ),
          ListTile(
            title: Text("Downloaded Content"),
            subtitle: Text("3 files"),
          ),
        ],
      ),
    );
  }
}
