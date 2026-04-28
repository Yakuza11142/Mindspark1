import 'package:dio/dio.dart';
import '../services/global_telco_zero_rating.dart'; // The detector we wrote earlier

class MtnSponsoredDataInterceptor extends Interceptor {
  // The Proxy URL MTN/Airtel gives you when you sign the B2B contract
  static const String mtnSponsoredProxy = "http://sponsored-data.mtn.com.ng:8080";
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 1. Check if the user is using an MTN/Airtel SIM
    var networkInfo = await GlobalTelcoZeroRating.checkIspStatus();
    
    if (networkInfo['isSponsored'] == true) {
      print("📡 ROUTING TRAFFIC THROUGH ${networkInfo['carrier']} FREE DATA PORTAL...");
      
      // 2. Add the special headers required by the Telco to verify it's your app
      options.headers['X-Sponsored-App-ID'] = "Mind_Spark_2026";
      options.headers['X-Zero-Rated'] = "true";
      
      // In a real advanced setup, you configure the Dio HttpClientAdapter to use the proxy
    }
    
    super.onRequest(options, handler);
  }
}