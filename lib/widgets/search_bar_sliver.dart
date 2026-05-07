import 'package:flutter/material.dart';
import 'glass_container.dart';

class SearchBarSliver extends StatelessWidget {
  const SearchBarSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true, // Disappears on scroll down, appears on scroll up
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: GlassContainer(child: const TextField(decoration: InputDecoration(hintText: "Search...", border: InputBorder.none, prefixIcon: Icon(Icons.search)))),
      ),
    );
  }
}