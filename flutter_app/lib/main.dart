import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'services/auth_service.dart';
import 'providers/auth_provider.dart';

void main() {
  final dio = Dio();
  final authService = AuthService(dio: dio);
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(authService),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(title: const Text('My App')),
        body: const Center(child: Text('Привет, MyApp!')),
      ),
    );
  }
}