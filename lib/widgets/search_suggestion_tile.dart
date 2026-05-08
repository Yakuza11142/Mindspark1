import 'package:flutter/material.dart';

class SearchSuggestionTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SearchSuggestionTile({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.history, color: Colors.grey),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}