import 'package:flutter/material.dart';
import '../services/bookmark_service.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Lessons")),
      body: FutureBuilder<List<String>>(
        future: BookmarkService.get(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snap.data!.length,
            itemBuilder: (ctx, i) => ListTile(title: Text(snap.data![i]), leading: const Icon(Icons.bookmark)),
          );
        },
      ),
    );
  }
}