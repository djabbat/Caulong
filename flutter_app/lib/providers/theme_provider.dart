import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('dark_mode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = !_isDarkMode;
    await prefs.setBool('dark_mode', _isDarkMode);
    notifyListeners();
  }

  // Определяем системную тему
  void syncWithSystemTheme(BuildContext context) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    _isDarkMode = brightness == Brightness.dark;
    notifyListeners();
  }
}