import 'package:flutter/material.dart';

class PetController extends ChangeNotifier {
  // Global Singleton Pattern
  static final PetController _instance = PetController._internal();
  factory PetController() => _instance;
  PetController._internal();

  // Observable Global State
  String name = "Scholar Guardian";
  String species = "Avian-C";
  double health = 0.85;
  int xp = 1200;

  void updateStats(int addedXp, double healthDelta) {
    xp += addedXp;
    health = (health + healthDelta).clamp(0.0, 1.0);
    notifyListeners(); // Updates all UI globally
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StudyPetScreen extends StatelessWidget {
  const StudyPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = PetController(); // Access global instance

    return Scaffold(
      appBar: AppBar(title: const Text("ACADEMIC COMPANION")),
      body: ListenableBuilder(
        listenable: pet,
        builder: (context, _) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Floating Animation
                Text("🛡️", style: const TextStyle(fontSize: 100))
                    .animate(onPlay: (c) => c.repeat(reverse: true))
                    .moveY(begin: -15, end: 15, duration: 2500.ms, curve: Curves.easeInOut),
                
                const SizedBox(height: 40),
                
                Text(pet.name.toUpperCase(), 
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
                
                Text("TYPE: ${pet.species}", 
                  style: const TextStyle(color: Colors.grey, fontSize: 14)),
                
                const SizedBox(height: 20),
                
                // Professional Health Bar
                SizedBox(
                  width: 200,
                  child: LinearProgressIndicator(
                    value: pet.health,
                    backgroundColor: Colors.grey.shade300,
                    color: pet.health < 0.3 ? Colors.red : Colors.blueAccent,
                    minHeight: 8,
                  ),
                ),
                
                const SizedBox(height: 10),
                Text("VITALITY: ${(pet.health * 100).toInt()}%", 
                  style: const TextStyle(fontWeight: FontWeight.w600)),
                  
                const SizedBox(height: 50),
                
                ElevatedButton.icon(
                  onPressed: () => _navigateToLesson(context),
                  icon: const Icon(Icons.menu_book),
                  label: const Text("INITIALIZE LEARNING SESSION"),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToLesson(BuildContext context) {
    // Navigate to your Exam/Lesson module
  }
}
