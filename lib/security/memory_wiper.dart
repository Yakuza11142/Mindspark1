import 'dart:typed_data';

class MemoryWiper {
  static void wipeBuffer(Uint8List buffer) {
    for (int i = 0; i < buffer.length; i++) {
      buffer[i] = 0; // Overwrite secret data in RAM immediately
    }
    print("Security: Memory block wiped.");
  }
}