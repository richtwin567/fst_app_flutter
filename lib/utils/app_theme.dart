import 'package:flutter/material.dart';

class AppTheme {
  static get apptheme {
    return ThemeData(
      // Define the default brightness and colors.
      primaryColor: Color.fromRGBO(0,62,138, 1),
      accentColor: Color.fromRGBO(18, 29, 72, 1),

      // Define the default font family.
      fontFamily: 'Montserrat',

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
