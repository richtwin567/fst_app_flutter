import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/home_view_model.dart';
import 'package:fst_app_flutter/screens/homescreen/home_view_mobile.dart';
import 'package:fst_app_flutter/screens/homescreen/home_view_tablet.dart';
import 'package:fst_app_flutter/widgets/base_widget.dart';
import 'package:fst_app_flutter/widgets/orientation_layout.dart';
import 'package:fst_app_flutter/widgets/screen_type_layout.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context) => ScreenTypeLayout(
        mobile: OrientationLayout(
          portrait: (context) => HomeMobilePortrait(),
          landscape: (context) => HomeMobileLandscape(),
        ),
        tablet: HomeTablet(),
      ),
    );
  }
}
