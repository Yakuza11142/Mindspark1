import 'package:flutter/services.dart';

class RamDefragmenter {
  static void purge() {
    // Calls low-memory warning manually to trigger OS cleanup
    SystemChannels.system.invokeMethod('System.lowMemory');
    print("🧹 Forcing OS RAM Defragmentation before CBT Exam...");
  }
}