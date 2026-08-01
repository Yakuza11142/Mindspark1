import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

  // Level Logic Constants
  static const int xpPerLevel = 500;

  // Derived Getters
  int get level => (xp / xpPerLevel).floor() + 1;
  int get xpInCurrentLevel => xp % xpPerLevel;
  double get xpProgress => xpInCurrentLevel / xpPerLevel;

  void updateStats(int addedXp, double healthDelta) {
    xp += addedXp;
    health = (health + healthDelta).clamp(0.0, 1.0);
    notifyListeners(); // Updates all UI globally
  }
}

class StudyPetScreen extends StatelessWidget {
  const StudyPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pet = PetController();

    return Scaffold(
      appBar: AppBar(title: const Text("ACADEMIC COMPANION")),
      body: ListenableBuilder(
        listenable: pet,
        builder: (context, _) {
          // Dynamic visual adjustments based on pet state
          final isLowHealth = pet.health < 0.3;
          final petEmoji = isLowHealth ? "🤕" : "🛡️";
          final healthColor = isLowHealth ? Colors.red : Colors.emerald;

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Floating Animation with dynamic emoji
                  Text(petEmoji, style: const TextStyle(fontSize: 100))
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .moveY(begin: -15, end: 15, duration: 2500.ms, curve: Curves.easeInOut),

                  const SizedBox(height: 30),

                  // Name & Level Badge
                  Text(pet.name.toUpperCase(), 
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 2)),
                  
                  const SizedBox(height: 4),
                  Chip(
                    label: Text("LVL ${pet.level}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    backgroundColor: Colors.blueAccent,
                  ),

                  Text("TYPE: ${pet.species}", 
                    style: const TextStyle(color: Colors.grey, fontSize: 14)),

                  const SizedBox(height: 30),

                  // Health / Vitality Bar
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(width: 200, child: Text("VITALITY", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: pet.health,
                      backgroundColor: Colors.grey.shade300,
                      color: healthColor,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("${(pet.health * 100).toInt()}%", style: TextStyle(fontWeight: FontWeight.w600, color: healthColor)),

                  const SizedBox(height: 20),

                  // XP / Progress Bar
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(width: 200, child: Text("EXPERIENCE", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey))),
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: 200,
                    child: LinearProgressIndicator(
                      value: pet.xpProgress,
                      backgroundColor: Colors.grey.shade300,
                      color: Colors.amber,
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text("${pet.xpInCurrentLevel} / $xpPerLevel XP", style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.amber)),

                  const SizedBox(height: 40),

                  ElevatedButton.icon(
                    onPressed: () => _navigateToLesson(context),
                    icon: const Icon(Icons.menu_book),
                    label: const Text("INITIALIZE LEARNING SESSION"),
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _navigateToLesson(BuildContext context) {
    // Simulating completing a short learning module (+60 XP, -0.10 Health)
    PetController().updateStats(60, -0.10); 
  }
}
