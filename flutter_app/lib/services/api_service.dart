import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> analyzeHealthData(Map<String, dynamic> data) async {
    try {
      final response = await dio.post('/analyze', data: data);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}