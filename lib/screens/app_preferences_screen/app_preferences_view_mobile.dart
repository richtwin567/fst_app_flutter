import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/routing/stateful_popup_route.dart';
import 'package:fst_app_flutter/widgets/preferences/theme_chooser_dialog.dart';
import 'package:provider/provider.dart';

class AppPreferencesViewMobileLandscape extends StatelessWidget {
  const AppPreferencesViewMobileLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AppPreferencesViewMobilePortrait extends StatelessWidget {
  const AppPreferencesViewMobilePortrait({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: false,
        ),
        body: Consumer<ThemeModel>(builder: (context, themeModel, child) {
          return ListView(children: [
            ListTile(
                leading: Icon(Icons.brush),
                title: Text('Theme'),
                subtitle:
                    Text(themeModel.selectedTheme.toString().substring(10)),
                onTap: () => Navigator.push(
                      context,
                      StatefulPopupRoute(
                          page: ThemeChooserDialog(),
                          settings: RouteSettings(arguments: themeModel)),
                    )),
            Divider(),
          ]);
        }));
  }
}
