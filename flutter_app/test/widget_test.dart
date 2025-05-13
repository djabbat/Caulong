import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:caulong_flutter/services/auth_service.dart';
import 'package:caulong_flutter/providers/auth_provider.dart';

void main() {
  testWidgets('Smoke test', (WidgetTester tester) async {
    final dio = Dio();
    final authService = AuthService(dio: dio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AuthProvider(authService: authService), // ✅ исправлено: именованный параметр
        child: const MaterialApp(
          home: Scaffold(
            body: Center(child: Text('Привет, MyApp!')),
          ),
        ),
      ),
    );

    expect(find.text('Привет, MyApp!'), findsOneWidget);
  });
}