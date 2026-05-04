import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'dart:io';

class SslPinningService {
  static Dio getSecureClient() {
    Dio dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      SecurityContext context = SecurityContext(withTrustedRoots: false);
      // In prod, you add your server's exact SSL certificate byte data here
      // context.setTrustedCertificatesBytes(certificateBytes);
      HttpClient client = HttpClient(context: context);
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => false; // REJECT ALL FAKES
      return client;
    };
    return dio;
  }
}