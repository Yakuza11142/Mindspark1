import 'package:flutter/material.dart';

class CbtReviewGridScreen extends StatelessWidget {
  // These now come from your Global Service
  final Stream<int> questionCountStream; 
  final List<bool> flaggedQuestions;
  final List<bool> answeredQuestions;

  const CbtReviewGridScreen({
    super.key, 
    required this.questionCountStream,
    required this.flaggedQuestions, 
    required this.answeredQuestions
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: questionCountStream,
      builder: (context, snapshot) {
        // Automatically expands as more questions are synced globally
        final totalQuestions = snapshot.data ?? 0;

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.purple[900],
            title: Text("Exam Review: $totalQuestions Questions Active"),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(20),
            // The logic: If Timetable is out, it switches to a 10-column "High Intensity" view
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: totalQuestions > 100 ? 10 : 5, 
              crossAxisSpacing: 8, 
              mainAxisSpacing: 8
            ),
            itemCount: totalQuestions, 
            itemBuilder: (ctx, i) {
              bool isFlagged = i < flaggedQuestions.length && flaggedQuestions[i];
              bool isAnswered = i < answeredQuestions.length && answeredQuestions[i];

              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: isAnswered ? Colors.greenAccent.withOpacity(0.8) : Colors.grey[900],
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isFlagged ? Colors.redAccent : Colors.cyanAccent.withOpacity(0.3), 
                    width: isFlagged ? 3 : 1
                  ),
                  boxShadow: isFlagged ? [const BoxShadow(color: Colors.red, blurRadius: 5)] : [],
                ),
                alignment: Alignment.center,
                child: Text("${i + 1}", style: const TextStyle(color: Colors.white, fontSize: 10)),
              );
            },
          ),
        );
      }
    );
  }
}
