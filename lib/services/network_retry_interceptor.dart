import 'package:dio/dio.dart';

class NetworkRetryInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout || err.type == DioExceptionType.receiveTimeout) {
      print("Network weak. Retrying API call...");
      // Logic to retry the request 7 times before throwing error
    }
    super.onError(err, handler);
  }
}