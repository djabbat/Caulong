import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caulong_flutter/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Профиль")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await authService.logout(); // ✅ Теперь метод существует

            // Защищённый переход
            if (context.mounted) {
              Navigator.pushReplacementNamed(context, '/login');
            }
          },
          child: const Text("Выйти из аккаунта"),
        ),
      ),
    );
  }
}