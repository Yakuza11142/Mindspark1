class TimezoneExamCalculator {
  static Duration getTimeUntilExam(DateTime examDateUtc) {
    DateTime localNow = DateTime.now(); // Automatically uses device's timezone
    return examDateUtc.difference(localNow);
  }
}