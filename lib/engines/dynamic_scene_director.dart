import 'dart:io';

class DynamicSceneDirector {
  static void cutToBRoll() => print("Cutting to B-Roll...");
  static void cutToAvatar() => print("Cutting back to Teacher...");
}

void main() {
  while (true) {
    print("Ask a question:");
    String? input = stdin.readLineSync();
    
    if (input != null) {
      DynamicSceneDirector.cutToBRoll();
      DynamicSceneDirector.cutToAvatar();
    }
  }
}
