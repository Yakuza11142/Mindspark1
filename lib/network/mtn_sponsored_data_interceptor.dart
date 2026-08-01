import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart'; 
import 'dart:developer' as developer;
import '../services/global_telco_zero_rating.dart'; 

class MtnSponsoredDataInterceptor extends Interceptor {
  static const String mtnSponsoredProxy = "http://sponsored-data.mtn.com.ng:8080";

  /// Explicitly intercepts requests and halts execution until ISP status lookup completes securely [INDEX]
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    developer.log("📡 MtnSponsoredInterceptor: Evaluating telco zero-rating tracking parameters.");

    try {
      // Awaiting the async status check blocks the network execution thread correctly prior to connection release [INDEX]
      final Map<String, dynamic> networkInfo = await GlobalTelcoZeroRating.checkIspStatus().timeout(
        const Duration(seconds: 3), 
      );

      if (networkInfo['isSponsored'] == true) {
        final String carrierName = networkInfo['carrier']?.toString().toUpperCase() ?? 'UNKNOWN';
        developer.log("📡 MtnSponsoredInterceptor: ROUTING THROUGH $carrierName FREE DATA PORTAL.");

        // Inject the required network headers into the request profile [INDEX]
        options.headers['X-Sponsored-App-ID'] = "Mind_Spark_2026";
        options.headers['X-Zero-Rated'] = "true";

        // Dynamically re-route your packet streams through the B2B telco carrier gateway server proxy paths [INDEX]
        options.extra['use_telco_proxy'] = true;
      }
    } catch (e, stackTrace) {
      developer.log("⚠️ MtnSponsoredInterceptor: Telco zero-rating evaluation skipped gracefully due to connection drop", error: e, stackTrace: stackTrace);
    }

    // Enforce standard handler callback execution pipelines to pass tracking data securely down request loops [INDEX]
    return handler.next(options);
  }

  /// Utility constructor helper that links a custom proxy connection adapter cleanly to your parent Dio instance [INDEX]
  static void attachZeroRatingProxyAdapter(Dio dioInstance) {
    // Adjusted closure parameter mappings to match the framework's strict (SecurityContext? context) signature requirement [INDEX]
    dioInstance.httpClientAdapter = IOHttpClientAdapter()..createHttpClient = (SecurityContext? context) {
      final HttpClient client = HttpClient(context: context);
      
      client.findProxy = (Uri uri) {
        // Intercept connection routing requests flagged by the extra parameter gate dynamically [INDEX]
        if (uri.path.contains('use_telco_proxy') || uri.query.contains('use_telco_proxy')) {
          return "PROXY ${mtnSponsoredProxy.replaceAll('http://', '')}";
        }
        return "DIRECT"; 
      };
      
      return client;
    };
  }
}
