import 'package:dio/dio.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class ZeroTrustInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final deviceInfo = DeviceInfoPlugin();
    String hwId = Platform.isAndroid ? (await deviceInfo.androidInfo).id : (await deviceInfo.iosInfo).identifierForVendor ?? "UNKNOWN";
    
    options.headers['x-hardware-id'] = hwId; // REQUIRED BY SUPABASE RLS
    super.onRequest(options, handler);
  }
}