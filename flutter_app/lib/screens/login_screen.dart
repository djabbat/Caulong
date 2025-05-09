import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Вход")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Авторизуйтесь для продолжения"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Имитация входа
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text("Войти"),
            ),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
              child: Text("Нет аккаунта? Зарегистрируйтесь"),
            )
          ],
        ),
      ),
    );
  }
}