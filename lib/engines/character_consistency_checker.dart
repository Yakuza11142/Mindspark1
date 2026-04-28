class CharacterConsistencyChecker {
  static String enforce(String aiText, String expectedName) {
    // If Spark accidentally calls himself Nexus, fix it.
    if (expectedName == "Spark" && aiText.contains("I am Nexus")) {
      return aiText.replaceAll("Nexus", "Spark");
    }
    return aiText;
  }
}