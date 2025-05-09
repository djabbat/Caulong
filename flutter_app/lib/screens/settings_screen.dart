import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caulong_flutter/providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Настройки")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Тема"),
              subtitle: Text(themeProvider.isDarkMode ? "Тёмная" : "Светлая"),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
            ListTile(
              title: Text("Системная тема"),
              subtitle: Text("Автоматически подстраиваться под тему устройства"),
              trailing: Switch(
                value: false, // можно сделать отдельный параметр
                onChanged: (_) {
                  themeProvider.syncWithSystemTheme(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}