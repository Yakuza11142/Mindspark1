import '../services/currency_manager.dart';
import '../services/firestore_service.dart';

class CloudSyncManager {
  static Future<void> sync(CurrencyManager localCurrency) async {
    // 1. Get Cloud Data
    var cloudData = await FirestoreService().getUserData();
    
    if (cloudData != null) {
      int cloudSparks = cloudData['sparks'] ?? 0;
      
      // 2. Logic: Keep the higher number (simple conflict resolution)
      if (cloudSparks > localCurrency.sparks) {
        // Cloud has more, update local
        // localCurrency.setSparks(cloudSparks); // You need to add a setter in CurrencyManager
      } else {
        // Local has more, update cloud
        FirestoreService().saveUserData(localCurrency.sparks, 0);
      }
    }
  }
}