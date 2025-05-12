import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio;

  AuthService({required this.dio});

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      // Логика при наличии токена
    }
  }

  Future<void> login(String email, String password) async {
    final response = await dio.post('/login', data: {'email': email, 'password': password});
    final token = response.data['access_token'];
    final refreshToken = response.data['refresh_token'];

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('refresh_token', refreshToken);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refresh_token');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('token');
  }

  Future<void> register(String email, String password) async {
    try {
      await dio.post('/register', data: {'email': email, 'password': password});
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    final response = await dio.post('/refresh-token', data: {'refresh_token': refreshToken});
    final newAccessToken = response.data['access_token'];

    await prefs.setString('token', newAccessToken);
  }

  void _handleError(DioException e) {
    if (e.response != null) {
      throw Exception('Ошибка: ${e.response?.data['detail']}');
    } else {
      throw Exception('Нет соединения с сервером');
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}