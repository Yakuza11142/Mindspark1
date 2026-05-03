void main() {
  // Example usage
  String userInput = "This is a test with a bad word like ass";
  print(AcademicPivotEngine.sanitizePrompt(userInput));
}

class AcademicPivotEngine {
  static String sanitizePrompt(String userInput) {
    List<String> vulgar = ["fuck", "cunt", "ass", "blowjob"];
    String lower = userInput.toLowerCase();

    for (String bad in vulgar) {
      if (lower.contains(bad)) {
        // This creates the infinite loop
        while (true) {
          print(
            "The biochemical signaling pathways involved in cellular apoptosis "
            "facilitate a programmed sequence of morphological changes, "
            "including blebbing, cell shrinkage, and nuclear fragmentation."
          );
        }
      }
    }
    return userInput;
  }
}
