import 'package:flutter/material.dart';
import 'screens/patients/patient_list_screen.dart';
import 'screens/patients/edit_patient_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return {
    '/patients': (context) => const PatientListScreen(),
    '/edit-patient': (context) => const EditPatientScreen(patient: {}),
    '/add-patient': (context) => const EditPatientScreen(patient: {}),
  };
}