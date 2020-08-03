import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fst_app_flutter/routing/generate_routes.dart';
import 'package:fst_app_flutter/routing/routes.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(0, 62, 138, 1.0),
  ));

  runApp(DevicePreview(child: FSTApp()));
}

class FSTApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: DevicePreview.appBuilder,
        title: 'FST App',
        initialRoute: contactRoute,
        onGenerateRoute: Router.generateRoute,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(0, 62, 138, 1.0),
          accentColor: Colors.blue[800],
          backgroundColor: Colors.white,
          fontFamily: 'Montserrat',
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white, opacity: 1.0),
              textTheme: TextTheme(
                  headline6: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold))),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ));
  }
}
