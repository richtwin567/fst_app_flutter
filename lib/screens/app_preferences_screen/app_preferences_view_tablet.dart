import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/app_preferences_screen/app_preferences_view_mobile.dart';

class AppPreferencesViewTabletLandscape extends StatelessWidget {
  const AppPreferencesViewTabletLandscape({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPreferencesViewMobilePortrait();
  }
}

class AppPreferencesViewTabletPortrait extends StatelessWidget {
  const AppPreferencesViewTabletPortrait({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPreferencesViewMobilePortrait();
  }
}
