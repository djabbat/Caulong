// flutter_app/lib/providers/auth_provider.dart

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService authService;
  bool _isLoggedIn = false;
  bool _isLoading = true;

  AuthProvider({required this.authService}) {
    checkLoginStatus();
  }

  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<void> checkLoginStatus() async {
    _isLoading = true;
    notifyListeners();
    try {
      _isLoggedIn = await authService.isLoggedIn();
    } catch (e) {
      _isLoggedIn = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    await authService.login(email, password);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    await authService.register(email, password);
    _isLoggedIn = true; // Если сервер сразу возвращает токен после регистрации
    notifyListeners();
  }

  Future<void> logout() async {
    await authService.logout();
    _isLoggedIn = false;
    notifyListeners();
  }
}