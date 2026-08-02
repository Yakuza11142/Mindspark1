import 'dart:convert';

class StringObfuscator {
  // A secure, private bitwise mask key to obscure raw string endpoints
  static const int _xorKey = 0x5A; 

  /// Safe bitwise obfuscation decoder protects local string constants from basic string scraping
  static String reveal(String encoded) {
    if (encoded.isEmpty) return "";

    try {
      // 1. Converts the string characters into a fast integer byte stream
      final List<int> bytes = encoded.codeUnits;
      
      // 2. Maps each byte against our private mathematical XOR mask
      final List<int> processedBytes = bytes.map((byte) => byte ^ _xorKey).toList();
      
      // 3. Reconstructs the safe string seamlessly inside machine memory
      return String.fromCharCodes(processedBytes);
    } catch (e) {
      return encoded; // Graceful fallback protects the layout if parsing fails
    }
  }
}
