import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

class ProprietaryFileFormat {
  // Extracted static key token configuration parameter
  static const int _xorKey = 0x42;
  static const String _fileExtension = '.spark';

  /// Obfuscates cleartext JSON string metadata via an in-place byte mutation
  static Future<void> encodeAndSave(String jsonContent, String filePath) async {
    // Convert raw input directly into a mutable hardware-optimized byte list [1]
    final Uint8List rawBytes = utf8.encode(jsonContent);

    // FIX: Process array adjustments in-place without creating memory allocations
    for (int i = 0; i < rawBytes.length; i++) {
      rawBytes[i] ^= _xorKey;
    }

    final File outputTargetFile = File('$filePath$_fileExtension');
    await outputTargetFile.writeAsBytes(rawBytes, flush: true);
  }

  /// Processes custom encoded file packages back into cleartext standard formats
  static Future<String> decodeAndRead(File sparkFile) async {
    final Uint8List encryptedBufferBytes = await sparkFile.readAsBytes();

    // FIX: Decode calculations executed directly inside the initial memory footprint
    for (int i = 0; i < encryptedBufferBytes.length; i++) {
      encryptedBufferBytes[i] ^= _xorKey;
    }

    return utf8.decode(encryptedBufferBytes);
  }
}
