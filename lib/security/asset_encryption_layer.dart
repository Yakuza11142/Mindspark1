import 'dart:io';
import 'dart:convert';
import '../config/secrets_fusion.dart'; // From earlier scripts

class AssetEncryptionLayer {
  static Future<void> secureAsset(File assetFile) async {
    List<int> bytes = await assetFile.readAsBytes();
    // Simple XOR with the secret salt to scramble the header
    List<int> secureBytes = bytes.map((b) => b ^ SecretsFusion.certSecretSalt.codeUnitAt(0)).toList();
    await assetFile.writeAsBytes(secureBytes);
  }

  static Future<List<int>> decryptForRendering(File secureFile) async {
    List<int> bytes = await secureFile.readAsBytes();
    return bytes.map((b) => b ^ SecretsFusion.certSecretSalt.codeUnitAt(0)).toList();
  }
}