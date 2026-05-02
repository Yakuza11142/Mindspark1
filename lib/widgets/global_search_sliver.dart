import 'package:flutter/material.dart';

class GlobalSearchSliver extends StatelessWidget {
  const GlobalSearchSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(30)),
          child: const TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search 10,000+ Topics...",
              prefixIcon: Icon(Icons.search, color: Colors.cyan),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}