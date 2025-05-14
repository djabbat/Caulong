// flutter_app/lib/services/auth_service.dart

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio dio;

  AuthService({required this.dio});

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token != null) {
        // Проверяем валидность токена
        final response = await dio.get(
          '/api/auth/validate-token',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
        return response.statusCode == 200;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/api/auth/login',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );

      final token = response.data['access_token'];
      final refreshToken = response.data['refresh_token'] ?? '';
      final expiresIn = response.data['expires_in'] ?? 3600;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('refresh_token', refreshToken);
      await prefs.setInt('token_expires_at', 
        DateTime.now().add(Duration(seconds: expiresIn)).millisecondsSinceEpoch);
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      
      if (token != null) {
        await dio.post(
          '/api/auth/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );
      }
      
      await _clearAuthData();
    } catch (e) {
      await _clearAuthData();
      rethrow;
    }
  }

  Future<void> _clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('refresh_token');
    await prefs.remove('token_expires_at');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final expiresAt = prefs.getInt('token_expires_at') ?? 0;
    
    return token != null && DateTime.now().millisecondsSinceEpoch < expiresAt;
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      await dio.post(
        '/api/auth/register',
        data: {
          'email': email,
          'password': password,
          'username': username,
        },
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<String?> refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refresh_token');
      
      if (refreshToken == null) return null;

      final response = await dio.post(
        '/api/auth/refresh-token',
        data: {'refresh_token': refreshToken},
      );
      
      final newToken = response.data['access_token'];
      final expiresIn = response.data['expires_in'] ?? 3600;
      
      await prefs.setString('token', newToken);
      await prefs.setInt('token_expires_at', 
        DateTime.now().add(Duration(seconds: expiresIn)).millisecondsSinceEpoch);
      
      return newToken;
    } on DioException catch (e) {
      await _clearAuthData();
      _handleError(e);
      return null;
    }
  }

  Future<String?> getToken() async {
    if (await isLoggedIn()) {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token');
    }
    return null;
  }

  void _handleError(DioException e) {
    String errorMessage = 'Произошла ошибка';
    
    if (e.response != null) {
      errorMessage = e.response?.data['detail'] ?? 
                    e.response?.data['message'] ?? 
                    e.response?.statusMessage ??
                    'Ошибка сервера';
    } else {
      errorMessage = e.message ?? 'Нет соединения с сервером';
    }
    
    throw AuthException(errorMessage);
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  
  @override
  String toString() => message;
}