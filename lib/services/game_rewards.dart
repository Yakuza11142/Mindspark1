import 'currency_manager.dart';

class GameRewards {
  static void grant(int score) {
    if (score > 5) CurrencyManager().addSparks(10);
    if (score > 20) CurrencyManager().addSparks(50);
  }
}