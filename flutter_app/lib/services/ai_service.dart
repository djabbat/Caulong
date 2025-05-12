import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AIService {
  final Dio dio;

  AIService({required this.dio});

  Future<Map<String, dynamic>> analyzeData(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      final response = await dio.post(
        '/ai/analyze',
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      return response.data;
    } on DioException catch (e) {
      _handleError(e);
      throw Exception('Ошибка анализа данных');
    }
  }

  void _handleError(DioException e) {
    if (e.response != null) {
      throw Exception('Ошибка: ${e.response?.data['detail']}');
    } else {
      throw Exception('Нет соединения с сервером');
    }
  }
}