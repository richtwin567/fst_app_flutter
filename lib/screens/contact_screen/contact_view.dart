import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_mobile.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_tablet.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

/// Contact Screen View. Controls the layout that is displayed using
/// [ScreenTypeLayout] and [OrientationLayout] to switch based on device type
/// and screen orientation.
class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => ContactViewMobilePortrait(),
        landscape: (context) => ContactViewMobileLandscape(),
      ),
      tablet: OrientationLayout(
        portrait: (context) => ContactViewTabletPortrait(),
        landscape: (context) => ContactViewTabletLandscape(),
      ),
    );
  }
}
