import 'package:flutter/material.dart';
import 'lesson_screen.dart';

class GlobalExamHub extends StatelessWidget {
  // Pass ANY exam data from ANY country (SAT, GRE, WAEC, IELTS, etc.)
  final List<Map<String, String>> examData;
  final String hubTitle;

  const GlobalExamHub({
    super.key,
    required this.examData,
    this.hubTitle = "Global Exam Simulators",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(hubTitle),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 0.85, // Balanced card height
        ),
        // Infinite scrolling logic using the provided global data
        itemBuilder: (context, index) {
          final item = examData[index % examData.length];
          return _examCard(
            context,
            item["title"] ?? "Unknown Exam",
            item["subtitle"] ?? "Standard Format",
            item["region"] ?? "Global",
          );
        },
      ),
    );
  }

  Widget _examCard(BuildContext ctx, String title, String subtitle, String region) {
    return GestureDetector(
      onTap: () => Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (_) => LessonScreen(
            topic: "$title ($region) Prep",
            isPro: true,
            isPidgin: false, // AI handles translation globally now
          ),
        ),
      ),
      child: Card(
        color: Colors.white.withOpacity(0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.cyanAccent.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.language, size: 35, color: Colors.white70),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyanAccent),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            // Region Badge for Global clarity
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                region.toUpperCase(),
                style: const TextStyle(color: Colors.amber, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
