import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/routing/generate_routes.dart';
import 'package:fst_app_flutter/utils/app_theme.dart';
import 'package:fst_app_flutter/utils/precache_rive.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ThemeModel themeModel = ThemeModel();
  try {
    await themeModel.init();
    await precacheRive();
  } catch (e) {
  }
  runApp(FSTApp(
    themeModel: themeModel,
  ));
}

class FSTApp extends StatelessWidget {
  final ThemeModel themeModel;

  FSTApp({Key key, this.themeModel}) : super(key: key);
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => themeModel,
        builder: (context, child) => Consumer<ThemeModel>(
              builder: (context, themeModel, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.getTheme(ThemeMode.light,
                      MediaQuery.platformBrightnessOf(context)),
                  darkTheme: AppTheme.getTheme(
                      ThemeMode.dark, MediaQuery.platformBrightnessOf(context)),
                  themeMode: themeModel.selectedTheme,
                  title: 'FST App',
                  builder: DevicePreview.appBuilder,
                  onGenerateRoute: Router.generateRoute,
                );
              },
            ));
  }
}
