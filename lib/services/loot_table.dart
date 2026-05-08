import 'dart:math';

class LootTable {
  static Map<String, dynamic> roll() {
    int r = Random().nextInt(100);
    if (r < 5) return {"item": "1000 Sparks", "rarity": "LEGENDARY"};
    if (r < 20) return {"item": "Free X-Ray", "rarity": "RARE"};
    return {"item": "10 Sparks", "rarity": "COMMON"};
  }
}