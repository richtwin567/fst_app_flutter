import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/scholarship_screen/scholarship_mobile.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class ScholarshipView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: OrientationLayout(
        portrait: (context) => ScholarshipMobile(),
        landscape: (context) => ScholarshipMobile(),
      ),
      //tablet: ScholarshipTablet(),
    );
  }
}