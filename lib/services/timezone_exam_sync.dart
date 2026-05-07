class TimezoneExamSync {
  static DateTime getLocalMidnightOfExam(String examDateString) {
    DateTime parsed = DateTime.parse(examDateString);
    // Returns the exact midnight of the exam day in the user's local timezone
    return DateTime(parsed.year, parsed.month, parsed.day);
  }
}