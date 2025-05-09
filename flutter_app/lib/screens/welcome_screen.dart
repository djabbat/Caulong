import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'about_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.health_and_safety, size: 80, color: Colors.teal),
            SizedBox(height: 20),
            Text(
              "Добро пожаловать в Caucasian Longevity",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Платформа для продления жизни на основе персональных данных, ИИ-анализа и натуральных решений Кавказа.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => LoginScreen())),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text("Войти"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => RegisterScreen())),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text("Зарегистрироваться"),
            ),
            TextButton(
              child: Text("Подробнее о платформе"),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AboutScreen()),
              ),
            )
          ],
        ),
      ),
    );
  }
}