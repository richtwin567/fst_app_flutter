import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fst_app_flutter/models/preferences/theme_preference.dart';

// TODO: document ThemeModel @richtwin567
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

  bool get isDark =>
      (selectedTheme == ThemeMode.dark) ||
      (selectedTheme == ThemeMode.system &&
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.dark);

  bool get isLight =>
      (selectedTheme == ThemeMode.light) ||
      (selectedTheme == ThemeMode.system &&
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light);
}
