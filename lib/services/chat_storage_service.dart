import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/chat_message_model.dart';

class ChatStorageService {
  static const String KEY = "spark_chat_history";

  static Future<void> saveMessage(String text, bool isUser) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(KEY) ?? [];
    
    LocalChatMessage msg = LocalChatMessage(text: text, isUser: isUser, time: DateTime.now());
    history.insert(0, jsonEncode(msg.toJson())); // Add to top
    
    if (history.length > 50) history.removeLast(); // Keep last 50 messages
    await prefs.setStringList(KEY, history);
  }

  static Future<List<LocalChatMessage>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(KEY) ?? [];
    return history.map((e) => LocalChatMessage.fromJson(jsonDecode(e))).toList();
  }
  
  static Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(KEY);
  }
}