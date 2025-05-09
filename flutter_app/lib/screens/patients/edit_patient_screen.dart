import 'package:flutter/material.dart';

class EditPatientScreen extends StatelessWidget {
  final Map<String, dynamic> patient;

  const EditPatientScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Редактировать пациента')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Имя: ${patient['first_name']}'),
            Text('Фамилия: ${patient['last_name']}'),
            Text('Email: ${patient['email']}'),
          ],
        ),
      ),
    );
  }
}