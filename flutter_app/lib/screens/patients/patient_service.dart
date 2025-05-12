import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/users.dart';

class PatientService {
  static const baseUrl = 'http://localhost:8000/patients/';

  Future<List<Patient>> fetchPatients({int page = 1, int pageSize = 10, String search = ""}) async {
    final url = '$baseUrl?skip=${(page - 1) * pageSize}&limit=$pageSize&search=$search';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> values = json.decode(response.body);
      return values.map((v) => Patient.fromJson(v)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }
}