import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/contact_view_model.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_mobile.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_tablet.dart';
import 'package:fst_app_flutter/widgets/base_widget.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

/// Contact Screen View. Controls the layout that is displayed using 
/// [ScreenTypeLayout] and [OrientationLayout] to switch based on device type 
/// and screen orientation. It uses the [ContactViewModel] to notify the framework of changes
/// and the [BaseWidget] to build the screen.
class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ContactViewModel>(
      viewModel: ContactViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context) => ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => ContactViewMobilePortrait(),
          landscape: (context) => ContactViewMobileLandscape(),
        ),
        tablet: OrientationLayout(
          portrait: (context) => ContactViewTabletPortrait(),
          landscape: (context) => ContactViewTabletLandscape(),
        ),
      ),
    );
  }
}
