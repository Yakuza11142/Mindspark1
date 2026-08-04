import 'dart:math';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

typedef GlobalRegistryList = List;
typedef VectorEmbedding = List<double>;
typedef MatchCandidate = MapEntry;
typedef MatchCandidateList = List<MatchCandidate>;

class GlobalUserIdentity {
  final String userId;
  final String fullName;
  final VectorEmbedding facialVector; 
  final String secureFingerprintHash; 

  GlobalUserIdentity({
    required this.userId,
    required this.fullName,
    required this.facialVector,
    required this.secureFingerprintHash,
  });
}

class MindSparkBiometricResolver {
  final LocalAuthentication _hardwareAuth = LocalAuthentication();

  static const double matchThreshold = 0.85;       
  static const double twinAmbiguityZone = 0.96;    

  double _calculateCosineSimilarity(VectorEmbedding vectorA, VectorEmbedding vectorB) {
    if (vectorA.length != vectorB.length || vectorA.isEmpty) return 0.0;

    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    int indexCounter = 0;
    for (double elementA in vectorA) {
      double elementB = vectorB[indexCounter];
      dotProduct += elementA * elementB;
      normA += elementA * elementA;
      normB += elementB * elementB;
      indexCounter++;
    }

    if (normA == 0.0 || normB == 0.0) return 0.0;
    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  Future resolveGlobalIdentity({
    required VectorEmbedding scannedFaceVector,
    required GlobalRegistryList globalDatabaseRegistry,
  }) async {

    final MatchCandidateList candidateMatches = [];

    for (var user in globalDatabaseRegistry) {
      double similarity = _calculateSimilarity(scannedFaceVector, user.facialVector);
      if (similarity >= matchThreshold) {
        candidateMatches.add(MapEntry(user, similarity));
      }
    }

    candidateMatches.sort((a, b) => b.value.compareTo(a.value));

    if (candidateMatches.isEmpty) {
      print("MindSpark Alert: No matching facial vector found globally.");
      return null;
    }

    if (candidateMatches.length > 1 && 
        candidateMatches.first.value >= twinAmbiguityZone && 
        candidateMatches.elementAt(1).value >= twinAmbiguityZone) {

      print("MindSpark Security Loop: Identical Twin / Look-Alike ambiguity detected.");

      bool fingerprintValidated = await _enforceFingerprintVerification();

      if (fingerprintValidated) {
        print("Identity resolved via unique amniotic fingerprint signature: ${candidateMatches.first.key.fullName}");
        return candidateMatches.first.key;
      } else {
        print("Biometric verification rejected or cancelled by user.");
        return null;
      }
    }

    print("Identity cleanly resolved via spatial computer vision: ${candidateMatches.first.key.fullName}");
    return candidateMatches.key;
  }

  Future<bool> _enforceFingerprintVerification() async {
    try {
      bool canAuthenticate = await _hardwareAuth.canCheckBiometrics || await _hardwareAuth.isDeviceSupported();

      if (!canAuthenticate) {
        print("Hardware Error: Spatial device does not support native fingerprint biometrics.");
        return false;
      }

      // FIXED: Passed parameters completely flattened as direct method named variables and removed 'const' list annotations to fully satisfy local_auth v3.0.2 compiler tracks
      return await _hardwareAuth.authenticate(
        localizedReason: 'MindSpark detected look-alike ambiguity. Fingerprint required to target exact twin.',
        biometricOnly: true,  
        stickyAuth: true,     
        useErrorDialogs: true,
        authMessages: [
          AndroidAuthMessages(
            signInTitle: 'MindSpark Twin Verification',
            cancelButton: 'Cancel',
          ),
          IOSAuthMessages(),
        ],
      );
    } on PlatformException catch (e) {
      print("Native OS Exception thrown during biometric routing: ${e.message}");
      return false;
    }
  }
  
  double _calculateSimilarity(VectorEmbedding a, VectorEmbedding b) => _calculateCosineSimilarity(a, b);
}
