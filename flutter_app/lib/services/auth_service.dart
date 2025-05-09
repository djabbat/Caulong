import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<void> login(String email, String password) async {
    // Здесь можно реализовать запрос к API
    await Future.delayed(Duration(seconds: 1));
    await saveToken("mock_jwt_token");
  }

  Future<void> register(String email, String password) async {
    // Здесь можно реализовать запрос к API
    await Future.delayed(Duration(seconds: 1));
    await saveToken("mock_jwt_token");
  }

  Future<void> logout() async {
    await removeToken();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}