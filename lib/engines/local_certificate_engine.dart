// Re-routes the old Web3 logic to standard PDF Generation (Script 101)
import '../engines/certificate_generator.dart';

class LocalCertificateEngine {
  static Future<void> issueSecureCertificate(String name, String course) async {
    print("Issuing standard localized PDF certificate (Non-Blockchain).");
    await CertificateGenerator.generate(name, course);
  }
}