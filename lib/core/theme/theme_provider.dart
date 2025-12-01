import 'package:flutter/material.dart';

import '../local_storage/local_storage.dart';

class ThemeProvider with ChangeNotifier {
  ThemeProvider() {
    toggleTheme(LocalStorage.instance.isDark);
  }

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool isDarkTheme = false;

  Future<void> toggleTheme(bool isDark) async {
    isDarkTheme = isDark;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await LocalStorage.instance.saveAppTheme(isDark ? 'true' : 'false');
    notifyListeners();
  }
}
