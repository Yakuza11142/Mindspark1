import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogExporter {
  static Future<void> write(String log) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mindspark_logs.txt');
    await file.writeAsString("${DateTime.now()}: $log\n", mode: FileMode.append);
  }
}