import 'package:flutter/material.dart';

class PatientListScreen extends StatelessWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Пациенты")),
      body: Center(child: Text("Список пациентов")),
    );
  }
}