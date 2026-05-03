import 'dart:typed_data';

class EncryptedMemoryBuffer {
  static void wipeBuffer(Uint8List secretData) {
    for (int i = 0; i < secretData.length; i++) {
      secretData[i] = 0; // Overwrite with zeroes
    }
    print("Memory Buffer Securely Wiped.");
  }
}