// lib/screens/home_screen.dart

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Главная")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Добро пожаловать в Caucasian Longevity",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Кнопка: Ввести данные здоровья
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/health-form');
              },
              icon: Icon(Icons.edit),
              label: Text("Ввести данные здоровья"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 16),

            // Кнопка: Мои биомаркеры
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/biomarkers');
              },
              icon: Icon(Icons.show_chart),
              label: Text("Мои биомаркеры"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 16),

            // Кнопка: Загрузить анализы
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/upload');
              },
              icon: Icon(Icons.upload_file),
              label: Text("Загрузить анализы"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 16),

            // Кнопка: Рекомендации
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/recommendations');
              },
              icon: Icon(Icons.lightbulb_outline),
              label: Text("Рекомендации"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 16),

            // Кнопка: Профиль
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: Icon(Icons.person),
              label: Text("Профиль"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),

            SizedBox(height: 16),

            // 🔥 НОВАЯ КНОПКА: Пациенты
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/patients');
              },
              icon: Icon(Icons.people_alt),
              label: Text("Пациенты"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}