class NationalPercentileRanker {
  static String getRank(int score) {
    // Top 0.88% of 1.93 million candidates (17,025 people)
    if (score >= 300) {
      return "Top 1% of Nigeria 🏆 - Elite Material for Medicine/Law/Engineering";
    }
    
    // Approx. top 6.08% of candidates (117,373 people)
    if (score >= 250) {
      return "Top 6% - Highly Competitive for Federal Universities 🎓";
    }
    
    // Approx. top 29.3% of candidates (565,988 people)
    // 200 is often the target for competitive state and federal admissions
    if (score >= 200) {
      return "Top 30% - Solid University Average 👍";
    }
    
    // JAMB set the 2025 minimum cut-off for universities at 150
    if (score >= 150) {
      return "Above National Minimum (150) - Eligible for many Universities 📚";
    }
    
    // JAMB set the 2025 minimum for Polytechnics/Colleges of Education at 100
    if (score >= 100) {
      return "Eligible for Polytechnic/Colleges of Education (Min. 100) 🛠️";
    }
    
    return "Below Admission Threshold - Immediate Revision Required ⚠️";
  }
}
