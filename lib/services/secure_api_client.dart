import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

class SecureApiClient {
  static Dio getClient() {
    final Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        headers: const <String, dynamic>{'Content-Type': 'application/json'},
      ),
    );

    // FIXED: Explicitly typed parameters inside handlers to clear all analyzer warnings
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        // Inject auth tokens here
        return handler.next(options);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) {
        if (e.type == DioExceptionType.connectionTimeout) {
          debugPrint("⚠️ Connection Timeout. User may be on Edge/3G network.");
        }
        return handler.next(e);
      },
    ));
    
    return dio;
  }
}
