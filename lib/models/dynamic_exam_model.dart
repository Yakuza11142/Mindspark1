import 'dart:convert';

class DynamicExamModel {
  final String name;
  final int maxScore;
  final List<String> subjects;
  final String gradingStyle;

  DynamicExamModel(this.name, this.maxScore, this.subjects, this.gradingStyle);

  factory DynamicExamModel.fromJson(String jsonStr) {
    var data = jsonDecode(jsonStr);
    return DynamicExamModel(
      data['name'], data['maxScore'], 
      List<String>.from(data['subjects']), data['grading_style']
    );
  }
}