import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Montserrat',
      //primaryColor: Color.fromRGBO(0, 62, 138, 1),
      accentColor: Color.fromRGBO(99, 135, 176, 1.0));

  static ThemeData _lightTheme = ThemeData(
    // Define the default brightness and colors.
    primaryColor: Color.fromRGBO(0, 62, 138, 1),
    accentColor: Colors.blue[800],
    brightness: Brightness.light,

    // Define the default font family.
    fontFamily: 'Montserrat',

    backgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(color: Colors.white, opacity: 1.0),
        textTheme: TextTheme(
            headline6: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold))),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static ThemeData getTheme(ThemeMode mode, Brightness platformBrightness) {
    if (mode == ThemeMode.dark) {
      return _darkTheme;
    } else if (mode == ThemeMode.light) {
      return _lightTheme;
    } else {
      return platformBrightness == Brightness.light
          ? _lightTheme
          : _darkTheme;
    }
  }
}
