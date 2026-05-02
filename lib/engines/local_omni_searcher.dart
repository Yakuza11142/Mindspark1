import '../data/mindspark_1000_data_megalith.dart';

class LocalOmniSearcher {
  static String? search(String query) {
    String result = OmniDataMegalith.instantSearch(query);
    if (!result.contains("Data not found")) {
      return result; // Instantly return offline data
    }
    return null; // Triggers Groq/OpenAI cloud fallback
  }
}