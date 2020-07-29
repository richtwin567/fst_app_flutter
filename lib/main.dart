import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contacts_page_general.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/homescreen/home_view.dart';

void main() => runApp(
      DevicePreview(
        child: FSTApp(),
      ),
    );

class FSTApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      initialRoute: ContactPage.routeName,
      routes: {
        '/home': (context) => HomeView(),
        ContactPage.routeName: (context) => ContactPage(),
        ContactDetailPage.routeName: (context) =>
            ContactDetailPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        accentColor: Color.fromRGBO(243, 191, 18, 1.0),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white, opacity: 1.0),     
        fontFamily: 'Montserrat',
        appBarTheme: AppBarTheme(textTheme: TextTheme(headline6: TextStyle(fontSize: 20.0, fontFamily: 'Montserrat', fontWeight: FontWeight.bold))),
        visualDensity: VisualDensity.adaptivePlatformDensity,
    ));
  }
}
