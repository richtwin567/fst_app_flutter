import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/utils/app_theme.dart';
import 'package:fst_app_flutter/screens/homescreen/home_view.dart';

void main() => runApp(
      DevicePreview(
        child: FSTApp(),
      ),
    );

class FSTApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.apptheme,
      builder: DevicePreview.appBuilder,
      home: HomeView(),
    );
  }
}
