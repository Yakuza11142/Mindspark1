import 'package:share_plus/share_plus.dart';

class ExportService {
  static void shareLesson(String text) {
    Share.share(text);
  }
}