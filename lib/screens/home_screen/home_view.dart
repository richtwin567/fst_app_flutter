import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/home_screen/home_view_mobile.dart';
import 'package:fst_app_flutter/screens/home_screen/home_view_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => HomeMobilePortrait(),
        landscape: (context) => HomeMobileLandscape(),
      ),
      tablet: HomeTablet(),
    );
  }
}
