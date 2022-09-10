import 'package:flutter/material.dart';

class ThemeModeNotifier with ChangeNotifier {
  ThemeMode _themeMode;

  ThemeModeNotifier(this._themeMode);

  getThemeMode() => _themeMode;

  setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
  }
}