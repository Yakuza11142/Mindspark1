import 'dart:convert';

// This represents your dynamic data source (AI or Database)
class DiscoveryService {
  static Future<List<String>> generateSubtopics(String topic) async {
    // In production, you would use an HTTP client to call Gemini or a backend
    // Example: final response = await http.post(apiUrl, body: {'topic': topic});

    // Simulating an AI generating deeper layers infinitely
    await Future.delayed(Duration(milliseconds: 500));
    return [
      "Introduction to $topic",
      "Advanced $topic Concepts",
      "History of $topic",
      "Future Applications of $topic"
    ];
  }
}

class TopicExpansionEngine {
  // Local cache to avoid re-fetching topics we've already expanded
  static final Map<String, List<String>> _treeCache = {};

  static Future<List<String>> getSubtopics(String mainTopic) async {
    // 1. Return from cache if we've been here before
    if (_treeCache.containsKey(mainTopic)) {
      return _treeCache[mainTopic]!;
    }

    // 2. Fetch "infinite" new branches for any string provided
    try {
      final subtopics = await DiscoveryService.generateSubtopics(mainTopic);

      // 3. Save to cache and return
      _treeCache[mainTopic] = subtopics;
      return subtopics;
    } catch (e) {
      return ["Expansion unavailable"];
    }
  }
}

void main() async {
  // Layer 1
  var physics = await TopicExpansionEngine.getSubtopics("Physics");
  print("Layer 1: $physics");

  // Layer 2 - Clicking the first subtopic to go deeper
  var deepPhysics = await TopicExpansionEngine.getSubtopics(physics[0]);
  print("Layer 2 (Infinite Dive): $deepPhysics");
}
