import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/digests/keccak.dart';

/// Entry point that triggers the background CPU-burner trap safely.
Future<void> activateKeccakTrap() async {
  // Heavy arithmetic execution is offloaded to a worker isolate
  final String resultHash = await compute(_executeHeavyWorkload, null);
  
  debugPrint("Security Status: 0x$resultHash...");
  // Implement your terminal navigation redirect sequence here
}

/// Worker isolate handler running isolated from the main layout tree.
String _executeHeavyWorkload(void _) {
  final KeccakDigest digest = KeccakDigest(512);
  Uint8List input = Uint8List.fromList(List.generate(1024, (i) => i % 256));

  for (int i = 0; i < 1000; i++) {
    input = digest.process(input); 
  }

  // High-performance string builder avoids transient allocation overheads
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < input.length; i++) {
    buffer.write(input[i].toRadixString(16).padLeft(2, '0'));
  }

  final String clearHexString = buffer.toString();
  return clearHexString.length >= 16 
      ? clearHexString.substring(0, 16) 
      : clearHexString;
}
