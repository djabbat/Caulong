import 'package:flutter/material.dart';
import '../../models/patient.dart';
import '../../screens/patients/patient_service.dart';
import '../edit_patient_screen.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  late Future<List<Patient>> futurePatients;
  final PatientService _service = PatientService();
  int _page = 1;
  final int _pageSize = 10;
  String _searchQuery = "";

  void _loadPatients() {
    setState(() {
      futurePatients = _service.fetchPatients(page: _page, pageSize: _pageSize, search: _searchQuery);
    });
  }

  @override
  void initState() {
    super.initState();
    futurePatients = _service.fetchPatients(page: _page, pageSize: _pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Пациенты')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-patient'),
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _searchQuery = value;
                _loadPatients();
              },
              decoration: InputDecoration(prefixIcon: Icon(Icons.search), hintText: "Поиск по имени или email"),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Patient>>(
              future: futurePatients,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var patient = snapshot.data![index];
                      return ListTile(
                        title: Text('${patient.firstName} ${patient.lastName}'),
                        subtitle: Text('Email: ${patient.email}'),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPatientScreen(patient: patient.toJson()),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _page > 1 ? () {
                  _page--;
                  _loadPatients();
                } : null,
                icon: Icon(Icons.arrow_left),
                label: Text("Назад"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _page++;
                  _loadPatients();
                },
                icon: Icon(Icons.arrow_right),
                label: Text("Вперед"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}