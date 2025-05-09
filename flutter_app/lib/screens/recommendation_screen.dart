// lib/screens/recommendation_screen.dart
import 'package:flutter/material.dart';

class RecommendationScreen extends StatelessWidget {
  const RecommendationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Рекомендации")),
      body: Center(child: Text("На основе ваших данных будут рекомендации")),
    );
  }
}