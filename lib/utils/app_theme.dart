import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get apptheme {
    return ThemeData(
      // Define the default brightness and colors.
      primaryColor: Color.fromRGBO(0,62,138, 1),
      accentColor: Colors.blue[800],

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
  }
}
