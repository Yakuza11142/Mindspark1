import '../services/currency_manager.dart';

class ChurnPredictor {
  static void preventUninstall(int consecutiveFails, CurrencyManager currency) {
    if (consecutiveFails >= 3) {
      currency.addSparks(200);
      print("User frustrated. Auto-dropping 200 Sparks to prevent uninstall.");
    }
  }
}