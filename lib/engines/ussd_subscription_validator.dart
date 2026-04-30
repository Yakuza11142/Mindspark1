class UssdSubscriptionValidator {
  static bool validateSmsReceipt(String smsBody, String expectedAmount) {
    String lowerBody = smsBody.toLowerCase();
    // E.g., "Acct: ***1234, Amt: NGN 4,500.00, Desc: Mind Spark"
    if (lowerBody.contains("mindspark") && lowerBody.contains(expectedAmount)) {
      print("✅ USSD Payment Verified Locally. Unlocking Pro.");
      return true;
    }
    return false;
  }
}