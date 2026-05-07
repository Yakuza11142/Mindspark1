class GooglePlayPolicyService {
  static const String subTerms = "Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period. Account will be charged for renewal within 24-hours prior to the end of the current period.";
  
  static bool hasAcceptedTerms(bool userTickedBox) {
    return userTickedBox;
  }
}