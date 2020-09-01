import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view_mobile.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class CampusMapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => CampusMapViewMobilePortrait(),
        landscape: (context) => CampusMapViewMobileLandscape(),
      ),
      tablet: OrientationLayout(
        portrait: (context) => CampusMapViewTabletPortrait(),
        landscape: (context) => CampusMapViewTabletLandscape(),
      ),
    );
  }
}


