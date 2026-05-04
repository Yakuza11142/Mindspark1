import 'dart:convert';
import 'dart:io';

class ProprietaryFileFormat {
  static Future<void> encodeAndSave(String jsonContent, String filePath) async {
    // Shifts the bytes to make it unreadable by standard text editors
    List<int> bytes = utf8.encode(jsonContent);
    List<int> proprietaryBytes = bytes.map((b) => b ^ 0x42).toList(); // XOR encryption
    
    File file = File('$filePath.spark');
    await file.writeAsBytes(proprietaryBytes);
  }

  static Future<String> decodeAndRead(File sparkFile) async {
    List<int> bytes = await sparkFile.readAsBytes();
    List<int> decodedBytes = bytes.map((b) => b ^ 0x42).toList();
    return utf8.decode(decodedBytes);
  }
}