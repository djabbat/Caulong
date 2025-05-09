import 'package:flutter/material.dart';
import 'package:caulong_flutter/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Профиль")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await _authService.logout(); // Удаляем токен

            // Защищённый переход
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: Text("Выйти из аккаунта"),
        ),
      ),
    );
  }
}