import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio;

  AuthService({required this.dio});

  Future<void> register(String email, String password) async {
    final data = {'email': email, 'password': password};
    await dio.post('/register', data: data);
  }

  Future<void> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final response = await dio.post('/login', data: data);

    // Сохраняем токен в SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['access_token']);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null;
  }

  // ✅ Добавьте этот метод
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token'); // Удаляем токен
  }
}