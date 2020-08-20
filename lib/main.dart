import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fst_app_flutter/models/theme_model.dart';
import 'package:fst_app_flutter/routing/generate_routes.dart';

import 'package:fst_app_flutter/utils/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(DevicePreview(child: FSTApp()));
}

class FSTApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
  
    return ChangeNotifierProvider(
          create: (context) => ThemeModel(),
          child: Consumer<ThemeModel>(
            builder:(context, themeModel, child) {
              SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppTheme.getTheme(themeModel.selectedTheme,MediaQuery.platformBrightnessOf(context)).primaryColor,
  ));
              return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getTheme(ThemeMode.light, MediaQuery.platformBrightnessOf(context)),
        darkTheme: AppTheme.getTheme(ThemeMode.dark, MediaQuery.platformBrightnessOf(context)),
        themeMode: themeModel.selectedTheme, 
        title: 'FST App',
        builder: DevicePreview.appBuilder,
        onGenerateRoute: Router.generateRoute,
      );
            },
    ));
  }
}
