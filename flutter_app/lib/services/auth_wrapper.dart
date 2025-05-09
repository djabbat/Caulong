import 'package:flutter/material.dart';

// Импорты из текущего проекта — замени 'caulong_flutter' на имя своего приложения
import 'package:caulong_flutter/services/auth_service.dart';
import 'package:caulong_flutter/screens/login_screen.dart';
import 'package:caulong_flutter/screens/home_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key}); // ✅ Используем super.key

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late AuthService _authService;
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    if (mounted) {
      setState(() {
        _isLoggedIn = isLoggedIn;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}