import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ThemePreference {
  var lightThemeStatus = ThemeMode.light.toString();
  var systemThemeStatus = ThemeMode.system.toString();
  var darkThemeStatus = ThemeMode.dark.toString();
  SharedPreferences prefs;

  _initializeFromDisk() async {
    prefs = await SharedPreferences.getInstance();
  }

  setThemeMode(ThemeMode option) async {
    await _initializeFromDisk();
    if (option == ThemeMode.dark) {
      prefs.setBool(darkThemeStatus, true);
      prefs.setBool(lightThemeStatus, false);
      prefs.setBool(systemThemeStatus, false);
    } else if (option == ThemeMode.light) {
      prefs.setBool(darkThemeStatus, false);
      prefs.setBool(lightThemeStatus, true);
      prefs.setBool(systemThemeStatus, false);
    } else {
      prefs.setBool(darkThemeStatus, false);
      prefs.setBool(lightThemeStatus, false);
      prefs.setBool(systemThemeStatus, true);
    }
  }

  Future<ThemeMode> get mode async {
    await _initializeFromDisk();
    if (prefs.getBool(darkThemeStatus) ?? false) {
      return ThemeMode.dark;
    } else if (prefs.getBool(lightThemeStatus) ?? false) {
      return ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }
}
