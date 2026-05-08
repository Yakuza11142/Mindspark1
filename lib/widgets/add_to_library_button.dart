import 'package:flutter/material.dart';
import '../services/library_manager.dart';

class AddToLibraryButton extends StatelessWidget {
  final String title, type;
  const AddToLibraryButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.bookmark_border, color: Colors.amber),
      onPressed: () {
        LibraryManager.saveItem(title, type);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved to Library")));
      },
    );
  }
}