import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart'; // ✅ Убедитесь, что файл существует

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key}); // ✅ Лучший стиль

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authService = Provider.of<AuthService>(context, listen: false);
        await authService.register(_emailController.text, _passwordController.text);

        if (!mounted) return; // ✅ Защита от использования устаревшего контекста
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Регистрация успешна")),
        );
        Navigator.pop(context);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Регистрация")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Введите email";
                  if (!value.contains('@')) return "Некорректный email";
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Пароль"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) return "Введите пароль";
                  if (value.length < 6) return "Пароль должен быть не менее 6 символов";
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text("Зарегистрироваться"),
              )
            ],
          ),
        ),
      ),
    );
  }
}