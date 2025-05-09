import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart'; // для SchedulerBinding
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.dark) return true;
    if (_themeMode == ThemeMode.light) return false;
    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  ThemeData get currentThemeData {
    if (_themeMode == ThemeMode.dark) {
      return ThemeData.dark();
    } else {
      return ThemeData.light();
    }
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    await saveTheme();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedTheme = prefs.getString('theme_mode');
    _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }
}