// lib/screens/health_form_screen.dart
import 'package:flutter/material.dart';

class HealthFormScreen extends StatelessWidget {
  const HealthFormScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Форма здоровья")),
      body: Center(child: Text("Введите данные о здоровье")),
    );
  }
}