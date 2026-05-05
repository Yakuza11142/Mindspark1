class PracticalSimulator {
  /// Global access: PracticalSimulator.getExperimentPrompt("Titration");
  static String getExperimentPrompt(String practical) {
    return """
    The user is performing a practical on '$practical'. 
    Generate a professional step-by-step virtual experiment guide. 
    Include the standard table of readings and expected observations for this specific experiment.
    """;
  }

  /// You can add more global prompt types here
  static String getTheoryPrompt(String topic) {
    return "Explain the fundamental principles of $topic in a simplified way.";
  }
}
