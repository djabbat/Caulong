import 'package:caulong_flutter/screens/register_screen.dart';
import 'package:caulong_flutter/utils/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/patients/patient_list_screen.dart'; // ✅ Новый экран пациентов

// Providers
import 'providers/theme_provider.dart';

// Services
import 'services/auth_service.dart';

// Hive
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();
  await Hive.openBox('patients_box'); // Открываем коробку для хранения данных о пациентах

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  await initNotifications(); // Инициализируем уведомления

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: AuthWrapper(),
    ),
  );
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final isLoggedIn = await _authService.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return Provider.value(
      value: _authService,
      child: MaterialApp(
        title: 'Caucasian Longevity',
        home: _isLoggedIn ? HomeScreen() : LoginScreen(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/patients': (context) => PatientListScreen(), // ✅ Подключаем новый экран
        },
      ),
    );
  }
}