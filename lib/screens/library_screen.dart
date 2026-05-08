import 'package:flutter/material.dart';
import '../services/library_manager.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Infinite Library")),
      body: FutureBuilder(
        future: LibraryManager.getItems(),
        builder: (ctx, snap) {
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          var items = snap.data as List<Map<String, dynamic>>;
          
          if (items.isEmpty) return const Center(child: Text("Library Empty"));

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) {
              var item = items[i];
              return ListTile(
                leading: Icon(
                  item['type'] == '3D' ? Icons.view_in_ar : Icons.book, 
                  color: Colors.cyanAccent
                ),
                title: Text(item['title']),
                subtitle: Text(item['date'].toString().split('T')[0]),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              );
            },
          );
        },
      ),
    );
  }
}