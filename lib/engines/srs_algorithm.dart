class SrsAlgorithm {
  // Calculates the next review date based on user's memory rating (0-5)
  static SrsResult calculateNextReview(int quality, int repetitions, double easeFactor, int interval) {
    if (quality < 3) {
      repetitions = 0;
      interval = 1;
    } else {
      if (repetitions == 0) {
        interval = 1;
      } else if (repetitions == 1) {
        interval = 6;
      } else {
        interval = (interval * easeFactor).round();
      }
      repetitions++;
    }

    easeFactor = easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (easeFactor < 1.3) easeFactor = 1.3;

    return SrsResult(repetitions, easeFactor, interval, DateTime.now().add(Duration(days: interval)));
  }
}

class SrsResult {
  final int repetitions;
  final double easeFactor;
  final int interval;
  final DateTime nextReviewDate;
  SrsResult(this.repetitions, this.easeFactor, this.interval, this.nextReviewDate);
}