import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<ApiService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text("Главная")),
      body: const Center(child: Text("Вы вошли!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final data = await api.get("/users/me");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(data.toString())),
              );
            }
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Ошибка: $e")),
              );
            }
          }
        },
        child: const Icon(Icons.person),
      ),
      bottomNavigationBar: ListTile(
        title: const Text("Выйти"),
        trailing: const Icon(Icons.logout),
        onTap: () {
          authService.logout();
          Navigator.pushReplacementNamed(context, '/login');
        },
      ),
    );
  }
}