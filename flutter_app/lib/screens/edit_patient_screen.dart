import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditPatientScreen extends StatefulWidget {
  final Map<String, dynamic> patient;

  const EditPatientScreen({super.key, required this.patient});

  @override
  State<EditPatientScreen> createState() => _EditPatientScreenState();
}

class _EditPatientScreenState extends State<EditPatientScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _birthDayController;
  late TextEditingController _birthMonthController;
  late TextEditingController _birthYearController;
  late TextEditingController _birthHourController;
  late String _gender;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.patient['first_name']);
    _lastNameController = TextEditingController(text: widget.patient['last_name']);
    _emailController = TextEditingController(text: widget.patient['email']);
    _phoneController = TextEditingController(text: widget.patient['phone'] ?? "");
    _birthDayController = TextEditingController(text: widget.patient['birth_day'].toString());
    _birthMonthController = TextEditingController(text: widget.patient['birth_month'].toString());
    _birthYearController = TextEditingController(text: widget.patient['birth_year'].toString());
    _birthHourController = TextEditingController(text: widget.patient['birth_hour'].toString());
    _gender = widget.patient['gender'];
  }

  Future<void> _updatePatient() async {
    final url = Uri.parse('http://localhost:8000/patients/${widget.patient['id']}');
    try {
      final response = await http.put(
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

      if (!mounted) return;

      if (response.statusCode == 200) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Обновлено")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ошибка обновления")));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ошибка сети")));
      }
    }
  }

  Future<void> _deletePatient() async {
    final url = Uri.parse('http://localhost:8000/patients/${widget.patient['id']}');
    try {
      final response = await http.delete(url);

      if (!mounted) return;

      if (response.statusCode == 204) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Удалено")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Ошибка удаления")));
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
      appBar: AppBar(title: const Text("Редактировать пациента")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(controller: _firstNameController, decoration: const InputDecoration(labelText: "Имя")),
              TextFormField(controller: _lastNameController, decoration: const InputDecoration(labelText: "Фамилия")),
              TextFormField(controller: _emailController, decoration: const InputDecoration(labelText: "Email")),
              TextFormField(controller: _phoneController, decoration: const InputDecoration(labelText: "Телефон")),

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
                onPressed: _updatePatient,
                icon: Icon(Icons.save),
                label: const Text("Сохранить"),
              ),

              const SizedBox(height: 10),

              ElevatedButton.icon(
                onPressed: _deletePatient,
                icon: Icon(Icons.delete),
                label: const Text("Удалить"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDayController.dispose();
    _birthMonthController.dispose();
    _birthYearController.dispose();
    _birthHourController.dispose();
    super.dispose();
  }
}