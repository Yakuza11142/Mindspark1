import 'package:flutter/material.dart';
import '../widgets/subject_grid_card.dart';

// Assuming your TopicExpansionEngine is in another file
// import 'topic_engine.dart'; 

class GlobalExplorerScreen extends StatefulWidget {
  final String topic; // The "Current" topic we are exploring
  
  // Default to "Universe" for the root screen
  const GlobalExplorerScreen({super.key, this.topic = "the Universe"});

  @override
  State<GlobalExplorerScreen> createState() => _GlobalExplorerScreenState();
}

class _GlobalExplorerScreenState extends State<GlobalExplorerScreen> {
  // Use a FutureBuilder to handle the "Infinite" loading
  late Future<List<String>> _subtopicsFuture;

  @override
  void initState() {
    super.initState();
    // Fetch subtopics dynamically based on the current screen's topic
    _subtopicsFuture = TopicExpansionEngine.getSubtopics(widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore ${widget.topic}"), 
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Diving into ${widget.topic}...", 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: _subtopicsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.purple));
                  }

                  final subtopics = snapshot.data ?? [];

                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, 
                      crossAxisSpacing: 15, 
                      mainAxisSpacing: 15
                    ),
                    itemCount: subtopics.length,
                    itemBuilder: (ctx, i) => GestureDetector(
                      onTap: () {
                        // INFINITE LOOP: Push the same screen with the new subtopic name
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GlobalExplorerScreen(topic: subtopics[i]),
                          ),
                        );
                      },
                      child: SubjectGridCard(
                        title: subtopics[i],
                        icon: Icons.auto_awesome, // Icons can also be generated/randomized
                        color: Colors.primaries[i % Colors.primaries.length],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
