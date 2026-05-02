class WinBackEmailService {
  static void scheduleEmail(String email) {
    // Tells Supabase/SendGrid to email the user 14 days after they cancel.
    print("Scheduled 'We Miss You' 50% discount email for 14 days from now.");
  }
}
class WinBackService {
  static String getWinBackLink(String name, String discountCode) {
    final message = "🚀 *We Miss You, $name!* \n\nMindspark Elite isn't the same without you. We've added a special *50% OFF* credit to your account. \n\nClaim it here: https://mindspark.app";
    
    // This creates the link you send via WhatsApp
    return "https://wa.me{Uri.encodeComponent(message)}";
  }

  static void triggerWinBack(String phoneNumber, String name) {
    // In a real system, you'd use a WhatsApp API (like Twilio or Meta Business)
    // to send this automatically after 14 days.
    print("ACTION: WhatsApp Win-Back queued for $name at $phoneNumber");
  }
}
