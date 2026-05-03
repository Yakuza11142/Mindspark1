import 'dart:io';

class DigitalCertificateBot {
  static Future<void> issueCertificate(String studentName, String subject, int score) async {
    String date = DateTime.now().toString().split(' ')[0];
    
    String certificate = """
    📜 DIGITAL CERTIFICATE OF ACHIEVEMENT 📜
    ---------------------------------------
    This certifies that
    
           $studentName
           
    has successfully completed the weekly 
    assessment in $subject with a score of:
    
               $score%
               
    Issued on: $date
    Verified by: MindSpark Elite ⚡
    ---------------------------------------
    """;
    
    print(certificate);
    print("📤 Certificate generated and sent to student record.");
  }
}

void main() async {
  while (true) {
    print("\n--- Generate Digital Certificate ---");
    
    stdout.write("Student Name: ");
    String? name = stdin.readLineSync();

    stdout.write("Subject: ");
    String? subject = stdin.readLineSync();
    
    stdout.write("Score: ");
    String? scoreInput = stdin.readLineSync();
    int score = int.tryParse(scoreInput ?? '0') ?? 0;

    if (name != null && subject != null) {
      await DigitalCertificateBot.issueCertificate(name, subject, score);
    }

    print("✔ Process complete. Press Enter for next student...");
    stdin.readLineSync();
  }
}
