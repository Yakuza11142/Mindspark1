class BrainAgeV2 {
  static int getAge(int memoryScore, int mathScore) {
    int baseAge = 50;
    return baseAge - (memoryScore * 2) - (mathScore);
  }
}