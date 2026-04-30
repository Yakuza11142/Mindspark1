import 'package:flutter/material.dart';
import 'universal_chat_screen.dart';

class HomeExploreScreen extends StatelessWidget {
  const HomeExploreScreen({super.key});

  final List<Map<String, dynamic>> subjects = const[
    {"title": "Physics", "icon": Icons.rocket_launch, "color": Colors.purpleAccent},
    {"title": "Mathematics", "icon": Icons.calculate, "color": Colors.blueAccent},
    {"title": "Chemistry", "icon": Icons.science, "color": Colors.orangeAccent},
    {"title": "Biology", "icon": Icons.biotech, "color": Colors.greenAccent},
    {"name": "Sumerian Language", "icon": Icons.translate, "color": Colors.amber},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers:[
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: Colors.transparent,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(20),
              title: const Text("What will you master?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Search any topic in the universe...",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true, fillColor: Colors.white10,
                  prefixIcon: const Icon(Icons.search, color: Colors.cyanAccent),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                ),
                onSubmitted: (val) {
                  if(val.isNotEmpty) Navigator.push(context, MaterialPageRoute(builder: (_) => UniversalChatScreen(topic: val)));
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.2),
              delegate: SliverChildBuilderDelegate(
                (ctx, i) {
                  final sub = subjects[i];
                  return GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UniversalChatScreen(topic: sub['title'] ?? sub['name']))),
                    child: Container(
                      decoration: BoxDecoration(
                        color: sub['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: sub['color'].withOpacity(0.4), width: 2),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Icon(sub['icon'], size: 40, color: sub['color']),
                          const SizedBox(height: 10),
                          Text(sub['title'] ?? sub['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                },
                childCount: subjects.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}