import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final box = Hive.box('lessons');
    return Scaffold(
      appBar: AppBar(title: const Text("Offline Library")),
      body: ListView.builder(
        itemCount: box.length,
        itemBuilder: (ctx, i) {
          String key = box.keyAt(i);
          return ListTile(title: Text(key), trailing: const Icon(Icons.offline_pin));
        },
      ),
    );
  }
}