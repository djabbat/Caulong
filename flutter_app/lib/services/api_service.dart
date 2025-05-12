import 'package:dio/dio.dart';
import 'auth_service.dart';

class ApiService {
  final Dio _dio;
  final AuthService _authService;

  ApiService({
    required Dio dio,
    required AuthService authService,
  })  : _dio = dio,
        _authService = authService;

  Future<dynamic> get(String endpoint) async {
    final token = await _authService.getToken();
    if (token == null) throw Exception("Токен не найден");

    final response = await _dio.get(
      endpoint,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final token = await _authService.getToken();
    if (token == null) throw Exception("Токен не найден");

    final response = await _dio.post(
      endpoint,
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }
}