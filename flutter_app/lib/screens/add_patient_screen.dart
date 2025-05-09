import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDayController = TextEditingController();
  final _birthMonthController = TextEditingController();
  final _birthYearController = TextEditingController();
  final _birthHourController = TextEditingController();
  String _gender = 'male';

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() != true) return;

    final url = Uri.parse('http://localhost:8000/patients/');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "first_name": _firstNameController.text,
          "last_name": _lastNameController.text,
          "email": _emailController.text,
          "phone": _phoneController.text,
          "birth_day": int.tryParse(_birthDayController.text),
          "birth_month": int.tryParse(_birthMonthController.text),
          "birth_year": int.tryParse(_birthYearController.text),
          "birth_hour": int.tryParse(_birthHourController.text),
          "gender": _gender,
        }),
      );

      // ✅ Проверка mounted — чтобы не использовать устаревший BuildContext
      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Пациент добавлен")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ошибка при добавлении")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ошибка сети")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Добавить пациента")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: "Имя"),
                validator: (value) =>
                    value?.isEmpty ?? true ? "Введите имя" : null,
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: "Фамилия"),
                validator: (value) =>
                    value?.isEmpty ?? true ? "Введите фамилию" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value?.isEmpty ?? true ? "Введите email" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Телефон"),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _birthDayController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "День"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _birthMonthController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Месяц"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      controller: _birthYearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Год"),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _birthHourController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Час рождения"),
              ),
              DropdownButtonFormField<String>(
                value: _gender,
                items: const [
                  DropdownMenuItem(value: 'male', child: Text('Мужской')),
                  DropdownMenuItem(value: 'female', child: Text('Женский')),
                ],
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _gender = newValue;
                    });
                  }
                },
                decoration: const InputDecoration(labelText: "Пол"),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: Icon(Icons.add),
                label: Text("Добавить"),
              )
            ],
          ),
        ),
      ),
    );
  }
}