import 'package:shared_preferences/shared_preferences.dart';
class AvatarStateSaver {
  static Future<void> saveOutfit(String charId, String outfitId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${charId}_outfit', outfitId);
  }
}