import 'dart:convert';
import 'dart:async'; // Import for timeout
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.97.9:5000";

  static Future<String?> generateImage(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/generate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"prompt": prompt}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['image']; // Base64 string
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error generating image: $e");
      return null;
    }
  }
}
