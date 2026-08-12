import 'dart:convert';
import 'dart:typed_data';
import 'package:pqccrypto/pqccrypto.dart';

class LatticeKeyPairContainer {
  final Uint8List publicKey;
  final Uint8List privateKey;

  const LatticeKeyPairContainer({
    required this.publicKey,
    required this.privateKey,
  });
}

class LatticeHashGenerator {
  /// Generates a randomized ML-DSA post-quantum lattice public/private key pair
  static LatticeKeyPairContainer generateLatticeKeyPair() {
    // Generate keypair based on crystal lattices (Module-Lattice Short Integer Solution problem)
    final keyPair = MlDsa.generateKeyPair(MlDsaParameter.mlDsa65);
    
    return LatticeKeyPairContainer(
      publicKey: keyPair.publicKey,
      privateKey: keyPair.privateKey,
    );
  }

  /// Signs data utilizing a post-quantum lattice-based digital signature algorithm (ML-DSA)
  static Uint8List generatePostQuantumSignature({
    required String payload,
    required String dynamicSalt,
    required Uint8List privateKey,
  }) {
    // Standardized preparation sequence combining payload elements into a uniform buffer
    final List<int> structuredBytes = utf8.encode("$dynamicSalt:$payload");
    final Uint8List targetDataBuffer = Uint8List.fromList(structuredBytes);

    // Cryptographically sign using the lattice private key
    return MlDsa.sign(
      parameter: MlDsaParameter.mlDsa65,
      privateKey: privateKey,
      message: targetDataBuffer,
    );
  }

  /// Validates a lattice signature to verify data authenticity and post-quantum security
  static bool verifyLatticeSignature({
    required String payload,
    required String dynamicSalt,
    required Uint8List signature,
    required Uint8List publicKey,
  }) {
    final List<int> structuredBytes = utf8.encode("$dynamicSalt:$payload");
    final Uint8List targetDataBuffer = Uint8List.fromList(structuredBytes);

    // Perform lattice proof verification against public signature keys
    return MlDsa.verify(
      parameter: MlDsaParameter.mlDsa65,
      publicKey: publicKey,
      message: targetDataBuffer,
      signature: signature,
    );
  }
}
