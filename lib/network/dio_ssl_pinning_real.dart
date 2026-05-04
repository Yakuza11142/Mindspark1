import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';

class DioSslPinningReal {
  static Dio createSecureClient() {
    Dio dio = Dio();
    // Real SHA-256 fingerprint of your server's SSL certificate
    List<String> trustedFingerprints =["E3:B0:C4:42:98:FC:1C:14:9A:FB:F4:C8:99:6F:B9:24:27:AE:41:E4:64:9B:93:4C:A4:95:99:1B:78:52:B8:55"];

    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      SecurityContext sc = SecurityContext(withTrustedRoots: false);
      HttpClient customClient = HttpClient(context: sc);
      customClient.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return trustedFingerprints.contains(cert.sha256.toString());
      };
      return customClient;
    };
    return dio;
  }
}