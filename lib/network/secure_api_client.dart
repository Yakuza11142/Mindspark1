import 'package:dio/dio.dart';

class SecureApiClient {
  static Dio getClient() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Inject auth tokens here
        return handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.type == DioExceptionType.connectionTimeout) {
          print("Connection Timeout. User may be on Edge/3G network.");
        }
        return handler.next(e);
      }
    ));
    return dio;
  }
}