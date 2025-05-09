import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("О Caucasian Longevity")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Icon(Icons.local_hospital, size: 80, color: Colors.teal),
            SizedBox(height: 20),
            Text(
              "Caucasian Longevity — это цифровая платформа долголетия, которая анализирует ваши данные и предлагает персонализированные стратегии улучшения здоровья и увеличения продолжительности жизни.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text("Форма здоровья"),
              subtitle: Text("Введите свои данные и получите индекс биологического возраста"),
            ),
            ListTile(
              leading: Icon(Icons.show_chart),
              title: Text("Биомаркеры"),
              subtitle: Text("Анализ показателей крови, гормонов и метаболитов"),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text("Маркетплейс"),
              subtitle: Text("Продукты, добавки и услуги для продления жизни"),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb_outline),
              title: Text("Рекомендации"),
              subtitle: Text("Персонализированные советы от ИИ и экспертов"),
            ),
          ],
        ),
      ),
    );
  }
}