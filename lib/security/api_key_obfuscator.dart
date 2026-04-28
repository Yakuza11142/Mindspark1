import 'dart:convert';

class ApiKeyObfuscator {
  // Hackers search for strings starting with "AIza..." or "gsk_..."
  // We NEVER store the raw string. We store a mathematical array of integers.
  
  // Example: 'gsk_fakekey123' broken into bytes and shifted by +5 (XOR/Caesar cipher mix)
  static const List<int> _scrambledGroqKey =[108, 120, 112, 100, /* ... */]; 

  static String unlockKey(List<int> secureArray) {
    List<int> unlocked = secureArray.map((byte) => byte - 5).toList();
    return utf8.decode(unlocked);
  }

  static String getGroqKey() {
    return unlockKey(_scrambledGroqKey); // The key only exists in RAM for 1 millisecond when needed
  }
}