import '../config/secrets.dart';

class SystemCheck {
  static void run() {
    print("SYSTEM CHECK:");
    print("Gemini Key: ${Secrets.geminiKey.isNotEmpty ? 'OK' : 'MISSING'}");
    print("AdMob ID: ${Secrets.admobAppId.isNotEmpty ? 'OK' : 'MISSING'}");
    print("Tripo Key: ${Secrets.tripoKey.isNotEmpty ? 'OK' : 'MISSING'}");
    print("System Ready.");
  }
}