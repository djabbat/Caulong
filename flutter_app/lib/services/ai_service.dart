import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AIService {
  final String baseUrl = 'https://your-fastapi-server.com/api ';

  Future<Map<String, dynamic>> analyzeBiomarkers(double age, double cholesterol, double glucose) async {
    final token = await _getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/ai/analyze'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode({'age': age, 'cholesterol': cholesterol, 'glucose': glucose}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Ошибка анализа');
    }
  }

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}