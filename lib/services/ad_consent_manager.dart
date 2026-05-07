import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdConsentManager {
  static Future<void> gatherConsent() async {
    ConsentDebugSettings debugSettings = ConsentDebugSettings(
      debugGeography: DebugGeography.debugGeographyDisabled,
    );
    ConsentRequestParameters params = ConsentRequestParameters(consentDebugSettings: debugSettings);

    ConsentInformation.instance.requestConsentInfoUpdate(params, () async {
      if (await ConsentInformation.instance.isConsentFormAvailable()) {
        ConsentForm.loadConsentForm((form) {
          form.show((formError) {
            // Consent gathered, initialize AdMob
            MobileAds.instance.initialize();
          });
        }, (error) => print("Consent Form Error: $error"));
      } else {
        MobileAds.instance.initialize(); // Init anyway if not required
      }
    }, (error) => print("Consent Info Error: $error"));
  }
}