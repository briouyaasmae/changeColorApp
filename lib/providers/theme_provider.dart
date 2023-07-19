import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final SharedPreferences prefs;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider(this.prefs) {
    getInitialTheme();
  }

  getInitialTheme() async {
    bool isDark = prefs.getBool('isDark') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  toggleTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    prefs.setBool('isDark', _themeMode == ThemeMode.dark);
    notifyListeners();
  }
}
