import 'dart:math';

class PetEngine {
  // Logic-based Leveling (No hardcoded stages)
  static int getLevel(int xp) => (sqrt(xp) / 5).floor() + 1;

  // Infinite Lexicon (Can be moved to an API or JSON file later)
  static const List<String> _tiers = ["Initiate", "Scholar", "Sentinel", "Guardian", "Warden", "Architect", "Exarch", "Aegis"];
  static const List<String> _divinities = ["Celestial", "Ethereal", "Eternal", "Prime", "Ancient", "Sovereign"];

  static String getPetStage(int xp, String subject) {
    final int level = getLevel(xp);
    
    // Calculate index based on level to cycle through tiers infinitely
    int tierIndex = (level ~/ 10) % _tiers.length;
    int divinityIndex = (level ~/ 50) % _divinities.length;

    String rank = _tiers[tierIndex];
    String prefix = level >= 50 ? "${_divinities[divinityIndex]} " : "";
    
    // Returns a dynamic title: e.g., "Eternal Warden of Physics (Lvl 152)"
    return "$prefix$rank of $subject (Lvl $level)";
  }
}
