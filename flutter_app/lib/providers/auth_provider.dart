import 'package:dio/dio.dart';

class AuthService {
  final Dio dio;

  AuthService({required this.dio});

  Future<void> register(String email, String password) async {
    final data = {'email': email, 'password': password};
    await dio.post('/register', data: data);
  }

  Future<void> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    await dio.post('/login', data: data);
  }

  Future<bool> isLoggedIn() async {
    return false;
  }
}