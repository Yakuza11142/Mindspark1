import 'package:flutter/material.dart';

class DynamicGlobalCountdown extends StatelessWidget {
  final String examCode;
  final DateTime examDate; // Passed down from Supabase database

  const DynamicGlobalCountdown({super.key, required this.examCode, required this.examDate});

  @override
  Widget build(BuildContext context) {
    int daysLeft = examDate.difference(DateTime.now()).inDays;
    if (daysLeft < 0) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.blueGrey[900], borderRadius: BorderRadius.circular(10)),
      child: Text(
        "$examCode EXAM IN: $daysLeft DAYS", 
        textAlign: TextAlign.center, 
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)
      ),
    );
  }
}
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