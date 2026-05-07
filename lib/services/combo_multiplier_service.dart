class ComboMultiplierService {
  static int getMultiplier(int secondsTaken) {
    if (secondsTaken < 3) return 3; // 3x XP
    if (secondsTaken < 6) return 2; // 2x XP
    return 1; // Standard
  }
}