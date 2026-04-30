class SubscriptionGracePeriod {
  static bool isInGracePeriod(DateTime expiryDate) {
    int daysOverdue = DateTime.now().difference(expiryDate).inDays;
    if (daysOverdue > 0 && daysOverdue <= 3) {
      print("🎁 Payment failed. 3-Day Grace Period active to protect student.");
      return true;
    }
    return false;
  }
}