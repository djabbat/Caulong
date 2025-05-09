import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Для подключения к API
import 'dart:convert';

// Удалите ненужный импорт: package:intl/intl.dart

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key}); // ✅ Добавлен конструктор с key

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  late String firstName, lastName, email, phone;
  late int birthYear, birthMonth, birthDay;
  late String birthTime, gender;

  final List<int> years = List.generate(100, (i) => DateTime.now().year - i);
  final List<int> months = List.generate(12, (i) => i + 1);
  final List<int> days = List.generate(31, (i) => i + 1);
  final List<String> genders = ['Мужской', 'Женский', 'Другое'];

  Future<void> _submitRegistration() async {
    if (_formKey.currentState?.validate() != true) return;

    _formKey.currentState!.save();

    final url = Uri.parse('https://your-fastapi-server.com/api/auth/register ');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "phone": phone,
          "birth_year": birthYear,
          "birth_month": birthMonth,
          "birth_day": birthDay,
          "birth_time": birthTime,
          "gender": gender,
        }),
      );

      // ✅ Проверка mounted — чтобы не использовать устаревший BuildContext
      if (!mounted) return;

      if (response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/login');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Регистрация успешна")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ошибка регистрации")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ошибка сети")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Регистрация")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Имя'),
                validator: (value) => value!.isEmpty ? 'Введите имя' : null,
                onSaved: (value) => firstName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Фамилия'),
                validator: (value) => value!.isEmpty ? 'Введите фамилию' : null,
                onSaved: (value) => lastName = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => !value!.contains('@') ? 'Некорректный email' : null,
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Телефон'),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length < 10 ? 'Некорректный номер' : null,
                onSaved: (value) => phone = value!,
              ),
              DropdownButtonFormField<int>(
                value: birthYear,
                items: years.map((year) => DropdownMenuItem(value: year, child: Text('$year'))).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Год рождения'),
                onSaved: (value) => birthYear = value!,
              ),
              DropdownButtonFormField<int>(
                value: birthMonth,
                items: months.map((month) => DropdownMenuItem(value: month, child: Text('$month'))).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Месяц рождения'),
                onSaved: (value) => birthMonth = value!,
              ),
              DropdownButtonFormField<int>(
                value: birthDay,
                items: days.map((day) => DropdownMenuItem(value: day, child: Text('$day'))).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'День рождения'),
                onSaved: (value) => birthDay = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Время рождения'),
                keyboardType: TextInputType.datetime,
                initialValue: '00:00',
                onSaved: (value) => birthTime = value!,
              ),
              DropdownButtonFormField<String>(
                value: genders[0],
                items: genders.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Пол'),
                onSaved: (value) => gender = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitRegistration,
                child: const Text("Зарегистрироваться"),
              )
            ],
          ),
        ),
      ),
    );
  }
}