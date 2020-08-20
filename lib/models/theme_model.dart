import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/preferences/theme_preference.dart';

class ThemeModel with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  //set to system theme by default
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeMode get selectedTheme => _currentTheme;

  set switchThemeTo(ThemeMode themeMode) {
    _currentTheme = themeMode;
    themePreference.setThemeMode(themeMode);
    notifyListeners();
  }
}
