import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

// Providers
import 'providers/theme_provider.dart';

// Services
import 'services/auth_service.dart';
import 'services/api_service.dart';

// Utils
import 'utils/navigation_service.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/home_screen.dart';
import 'screens/patients/patient_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализация Hive
  await Hive.initFlutter();
  await Hive.openBox('app_data');

  // Тема
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  // Настройка Dio
  final dio = Dio(BaseOptions(
    baseUrl: 'https://your-fastapi-server.com/api ',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json'},
  ));

  runApp(
    MultiProvider(
      providers: [
        // Тема
        ChangeNotifierProvider.value(value: themeProvider),

        // API-сервис (если используется отдельно)
        Provider(create: (_) => ApiService(dio)),

        // AuthService с правильной передачей Dio
        Provider(create: (_) => AuthService(dio: dio)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caulong',
      theme: Provider.of<ThemeProvider>(context).currentThemeData,
      navigatorKey: NavigationService.navigatorKey,
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/patients': (context) => const PatientListScreen(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  late AuthService _authService;
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    // Получаем инстанс AuthService из провайдера
    _authService = Provider.of<AuthService>(context, listen: false);
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
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isLoggedIn ? const HomeScreen() : const LoginScreen();
  }
}