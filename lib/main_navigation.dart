import 'package:flutter/material.dart';
import 'home_explore_tab.dart';
import 'library_tab.dart';
import 'cinema_tab.dart'; // Import your new Cinema tab
import 'universal_chat_screen.dart';
import 'rank_tab.dart';
import 'profile_tab.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});
  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0;
  final List<Widget> _tabs = [
    const HomeExploreTab(),
    const LibraryTab(),
    const CinemaTab(), // The New Video Hub
    const UniversalChatScreen(topic: "Spark AI"),
    const RankTab(),
    const ProfileTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: IndexedStack(index: _idx, children: _tabs),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.black,
        indicatorColor: Colors.cyanAccent.withOpacity(0.2),
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.grid_view), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.bookmark_outline), label: 'Library'),
          NavigationDestination(icon: Icon(Icons.play_circle_outline), label: 'Cinema'), // Cinema Icon
          NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Spark AI'),
          NavigationDestination(icon: Icon(Icons.emoji_events), label: 'Rank'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Me'),
        ],
      ),
    );
  }
}
