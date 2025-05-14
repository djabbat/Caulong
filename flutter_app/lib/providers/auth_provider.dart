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

  Future<void> login({
    required String username,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await authService.login(
        username: username,
        password: password,
      );
      _isLoggedIn = true;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      await authService.register(
        email: email,
        password: password,
        username: username,
      );
      _isLoggedIn = true;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    try {
      await authService.logout();
      _isLoggedIn = false;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}