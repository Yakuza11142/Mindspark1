import '../engines/age_context_provider.dart';

class ParentCommunicationRouter {
  static Future<bool> shouldNotifyParent() async {
    String stage = await AgeContextProvider.getLifeStage();
    
    // IF THEY ARE 18 OR OLDER, DO NOT EMAIL THEIR PARENTS.
    if (stage == "ADULT") {
      print("🛑 Privacy Lock: User is 18+. Suppressing parental notifications.");
      return false; 
    }
    
    // If they are under 18, allow the email to send.
    return true;
  }
}