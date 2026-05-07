import 'dart:convert';
import 'package:http/http.dart' as http;

class FormulaVault {
  static const String _baseUrl = "https://yourservice.com";

  static Future<List<Formula>> fetchCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$category'));

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Formula.fromJson(item)).toList();
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      // In a ministerial app, log the error securely and return a fallback or empty list
      return [];
    }
  }
}
class Formula {
  final String name;
  final String latex;

  Formula({required this.name, required this.latex});

  factory Formula.fromJson(Map<String, dynamic> json) {
    return Formula(name: json['name'], latex: json['latex']);
  }
}
FutureBuilder<List<Formula>>(
  future: FormulaVault.fetchCategory('physics'),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LinearProgressIndicator(); // Minimalist loading
    }
    
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final item = snapshot.data![index];
          return ListTile(
            title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.latex),
          );
        },
      );
    }
    
    return const Text("Service temporarily unavailable.");
  },
)
