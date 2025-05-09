import 'package:flutter/material.dart';

class BiomarkerChartScreen extends StatelessWidget {
  const BiomarkerChartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Графики биомаркеров")),
      body: Center(child: Text("Отображение графиков")),
    );
  }
}