class RealCbtQuestion {
  final String id;
  final String text;
  final List<String> options;
  final String correctOption;
  
  // The "Global" key: dynamic storage for any field (Latex, Images, Diagrams, AR, etc.)
  final Map<String, dynamic> metadata;

  RealCbtQuestion({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOption,
    required this.metadata,
  });

  factory RealCbtQuestion.fromJson(Map<String, dynamic> json) {
    // Extract core fields and scoop everything else into metadata
    final coreFields = ['id', 'text', 'options', 'correct_option'];
    final meta = Map<String, dynamic>.from(json)
      ..removeWhere((key, value) => coreFields.contains(key));

    return RealCbtQuestion(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctOption: json['correct_option'] ?? '',
      metadata: meta,
    );
  }

  // Global helper to retrieve any specific attribute safely
  T? getAttribute<T>(String key) => metadata[key] as T?;
}
