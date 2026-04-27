// Add hive_flutter to pubspec
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('lessons');
  }

  static void saveLesson(String topic, String content) {
    Hive.box('lessons').put(topic, content);
  }

  static String? getLesson(String topic) {
    return Hive.box('lessons').get(topic);
  }
}