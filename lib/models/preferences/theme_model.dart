import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_preference.dart';

class ThemeModel with ChangeNotifier {
  static ThemePreference _themePreference = ThemePreference();
  //set to system theme by default
  ThemeMode _currentTheme;

  init() async {
    _currentTheme = await _themePreference.mode;
  }

  ThemeMode get selectedTheme => _currentTheme;

  switchThemeTo(ThemeMode themeMode) {
    _currentTheme = themeMode;
    _themePreference.setThemeMode(themeMode);
    notifyListeners();
  }
}
