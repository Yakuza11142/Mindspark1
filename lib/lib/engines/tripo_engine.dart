import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../config/secrets.dart';

class TripoEngine {
  Future<String?> generate3D(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.tripo3d.ai/v2/openapi/task"),
        headers: {"Authorization": "Bearer ${Secrets.tripoKey}", "Content-Type": "application/json"},
        body: jsonEncode({"type": "text_to_model", "prompt": "A 3D model of $prompt, glb format"})
      );

      if (res.statusCode == 200) {
        String id = jsonDecode(res.body)['data']['task_id'];
        return await _poll(id);
      }
    } catch (e) { print("Tripo Error: $e"); }
    return null;
  }

  Future<String?> _poll(String id) async {
    for (int i = 0; i < 20; i++) {
      await Future.delayed(const Duration(seconds: 2));
      final res = await http.get(Uri.parse("https://api.tripo3d.ai/v2/openapi/task/$id"), headers: {"Authorization": "Bearer ${Secrets.tripoKey}"});
      final data = jsonDecode(res.body)['data'];
      if (data['status'] == "SUCCESS") return data['output']['model'];
    }
    return null;
  }
}