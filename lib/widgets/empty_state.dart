import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String text;
  const EmptyState({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.inbox, size: 60, color: Colors.grey),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(color: Colors.grey))
        ],
      ),
    );
  }
}