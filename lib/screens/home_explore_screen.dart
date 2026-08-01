import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'universal_chat_screen.dart';

class HomeExploreScreen extends StatelessWidget {
  const HomeExploreScreen({super.key});

  // Standardized dictionary map structures across all items using a uniform 'title' tracking parameter key [INDEX]
  static const List<Map<String, dynamic>> _subjectsRegistry = [
    {
      "title": "Physics",
      "icon": Icons.rocket_launch,
      "color": Colors.purpleAccent
    },
    {
      "title": "Mathematics",
      "icon": Icons.calculate,
      "color": Colors.blueAccent
    },
    {
      "title": "Chemistry", 
      "icon": Icons.science, 
      "color": Colors.orangeAccent
    },
    {
      "title": "Biology", 
      "icon": Icons.biotech, 
      "color": Colors.greenAccent
    },
    {
      "title": "Sumerian Language", // Aligned key parameter structure [INDEX]
      "icon": Icons.translate,
      "color": Colors.amber
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(), // Ensures smooth elastic bounce across multi-platform screen frames [INDEX]
        slivers: [
          const SliverAppBar(
            expandedHeight: 120,
            backgroundColor: Colors.transparent,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.all(20),
              title: Text(
                "What will you master?",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.search, // Enhances system keyboard interaction feedback loops [INDEX]
                decoration: InputDecoration(
                  hintText: "Search any topic in the universe...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: Colors.white10,
                  prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (String val) {
                  final String cleanedQuery = val.trim();
                  if (cleanedQuery.isNotEmpty) {
                    developer.log("🔍 HomeExplore: Navigating to custom text query container: $cleanedQuery");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UniversalChatScreen(topic: cleanedQuery),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final Map<String, dynamic> sub = _subjectsRegistry[index];
                  
                  // Defensive unpacking strategy handles missing or corrupt dictionary types safely [INDEX]
                  final String subjectTitle = sub['title']?.toString() ?? 'Unknown Curriculum';
                  final IconData displayIcon = (sub['icon'] is IconData) ? sub['icon'] as IconData : Icons.book_rounded;
                  final Color surfaceColor = (sub['color'] is Color) ? sub['color'] as Color : Colors.cyanAccent;

                  return GestureDetector(
                    onTap: () {
                      developer.log("📚 HomeExplore: Selected subject routing target layout: $subjectTitle");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UniversalChatScreen(topic: subjectTitle),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: surfaceColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: surfaceColor.withOpacity(0.35), 
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(displayIcon, size: 38, color: surfaceColor),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              subjectTitle,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis, // Prevents text overflow breaks if font scales are high [INDEX]
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                childCount: _subjectsRegistry.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
