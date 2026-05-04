import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioCacheInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.method == 'GET') {
      final prefs = await SharedPreferences.getInstance();
      String? cachedData = prefs.getString(options.uri.toString());
      
      if (cachedData != null) {
        print("⚡ Serving from Cache, saving API costs.");
        return handler.resolve(Response(requestOptions: options, data: cachedData, statusCode: 200));
      }
    }
    super.onRequest(options, handler);
  }
}