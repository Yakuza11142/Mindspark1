import 'dart:convert';
import 'dart:typed_data';

class BinaryLessonPacker {
  static Uint8List pack(String data) {
    List<int> bytes = utf8.encode(data);
    return Uint8List.fromList(bytes); // Stored directly in SQLite as a BLOB
  }

  static String unpack(Uint8List packedData) {
    return utf8.decode(packedData);
  }
}