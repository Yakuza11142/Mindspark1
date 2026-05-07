import 'package:supabase_messaging/supabase_messaging.dart';

class FcmService {
  static Future<void> init() async {
    SupabaseMessaging messaging = SupabaseMessaging.instance;
    await messaging.requestPermission();
    
    SupabaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Got a message: ${message.notification?.title}");
      // Show local notification
    });
  }
  
  static Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}