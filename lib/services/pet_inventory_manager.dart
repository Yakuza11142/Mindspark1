import 'package:shared_preferences/shared_preferences.dart';

class PetInventoryManager {
  static Future<void> saveActivePet(String imageUrl, String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('active_pet_url', imageUrl);
    await prefs.setString('active_pet_type', type);
  }
}