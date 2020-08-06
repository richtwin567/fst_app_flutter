import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fst_app_flutter/routing/generate_routes.dart';
import 'package:fst_app_flutter/utils/app_theme.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppTheme.apptheme.primaryColor,
  ));

  runApp(DevicePreview(child: FSTApp()));
}

class FSTApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.apptheme,
      title: 'FST App',
      builder: DevicePreview.appBuilder,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
