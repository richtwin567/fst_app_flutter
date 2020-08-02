import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/contact_screen/contacts_page_general.dart';
import 'routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case contactRoute:
        return MaterialPageRoute(builder: (context) => ContactPage());
      case contactDetailRoute:
        return MaterialPageRoute(builder: (context) => ContactDetailPage(settings.arguments));
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  body: Center(
                      child: Text('Can\'t access ${settings.name} page')),
                ));
    }
  }
}
