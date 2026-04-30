import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SystemController {
  final client = Supabase.instance.client;

  // BACKEND: Sync Face Scan with Supabase
  Future<Map<String, dynamic>?> recognizeFace(String faceHash) async {
    final response = await client
        .from('profiles')
        .select()
        .eq('face_hash', faceHash)
        .single();
    return response;
  }

  // FRONTEND -> BACKEND: Ask Groq AI for Human Thinking
  Future<String> getAIResponse(String prompt) async {
    final res = await http.post(
      Uri.parse('https://groq.com'),
      headers: {
        'Authorization': 'Bearer ${dotenv.env['GROQ_KEY']}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        "model": "llama3-70b-8192",
        "messages": [{"role": "user", "content": prompt}]
      }),
    );
    return jsonDecode(res.body)['choices']['message']['content'];
  }
}
