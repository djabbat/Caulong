import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // ✅ Добавлен импорт для Provider
import 'package:caulong_flutter/services/auth_service.dart'; // ✅ Исправлен путь

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // ✅ Используем super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Главная")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Получаем AuthService через Provider
            final authService = Provider.of<AuthService>(context, listen: false);
            authService.logout(); // Выход пользователя
            Navigator.pushReplacementNamed(context, '/login'); // Переход на экран входа
          },
          child: Text("Выйти"),
        ),
      ),
    );
  }
}