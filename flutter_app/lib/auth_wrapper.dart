import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caulong_flutter/providers/theme_provider.dart';
import 'package:caulong_flutter/screens/home_screen.dart';
import 'package:caulong_flutter/screens/login_screen.dart';
import 'package:caulong_flutter/services/auth_service.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  late AuthService _authService;
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _authService = AuthService();
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

    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Caucasian Longevity',
      theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: _isLoggedIn ? HomeScreen() : LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}