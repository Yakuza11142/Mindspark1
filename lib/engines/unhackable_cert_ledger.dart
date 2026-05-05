import 'package:cloud_firestore/cloud_firestore.dart';

class UnhackableCertLedger {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // 1. MINT THE CERTIFICATE TO THE CLOUD
  static Future<String?> mintCertificate(String studentName, String course, int score) async {
    try {
      // Create a secure record in Google's servers
      DocumentReference docRef = await _db.collection('verified_certificates').add({
        'student_name': studentName,
        'course': course,
        'score': score,
        'issue_date': DateTime.now().toIso8601String(),
        'is_valid': true
      });
      
      return docRef.id; // This is the unhackable string (e.g., "7xKp9L2mQw...")
    } catch (e) {
      print("Database Error. Cannot mint certificate.");
      return null;
    }
  }

  // 2. VERIFY THE CERTIFICATE FROM THE CLOUD
  static Future<Map<String, dynamic>?> verify(String certId) async {
    try {
      DocumentSnapshot doc = await _db.collection('verified_certificates').doc(certId).get();
      if (doc.exists && doc['is_valid'] == true) {
        return doc.data() as Map<String, dynamic>;
      }
      return null; // FAKE CERTIFICATE
    } catch (e) {
      return null;
    }
  }
}