import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/app_preferences_screen/app_preferences_view_mobile.dart';
import 'package:fst_app_flutter/screens/app_preferences_screen/app_preferences_view_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class AppPreferencesView extends StatelessWidget {
  const AppPreferencesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => AppPreferencesViewMobilePortrait(),
        landscape: (context) => AppPreferencesViewMobileLandscape(),
      ),
      tablet: OrientationLayout(
        portrait: (context) => AppPreferencesViewTabletPortrait(),
        landscape: (context) => AppPreferencesViewTabletLandscape(),
      ),
    );
  }
}
