import 'package:shared_preferences/shared_preferences.dart';
import '../models/dynamic_exam_model.dart';

class ExamDatabaseLocal {
  static Future<DynamicExamModel?> getMyExam() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonStr = prefs.getString('custom_exam_profile');
    if (jsonStr == null) return null;
    return DynamicExamModel.fromJson(jsonStr);
  }
}