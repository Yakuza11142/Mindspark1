class ExamTimeDistorter {
  static int applyDistortion(int actualSecondsPassed) {
    // 1 real second = 1.1 simulated seconds
    return (actualSecondsPassed * 1.1).round();
  }
}