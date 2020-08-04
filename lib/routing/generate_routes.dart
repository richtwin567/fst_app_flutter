import 'package:flutter/material.dart';
import 'package:fst_app_flutter/routing/slide_up_route.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view.dart';
import 'package:fst_app_flutter/screens/homescreen/home_view.dart';
import 'routes.dart';

/// Handles routing in the app
class Router {
  /// Controls how each [Route] is generated
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case contactRoute:
        return MaterialPageRoute(builder: (context) => ContactView());
      case contactDetailRoute:
        return SlideUpPageRoute(page: ContactDetailPage(settings.arguments));
      default:
        return MaterialPageRoute(
            builder: (context) => HomeView());
    }
  }
}
