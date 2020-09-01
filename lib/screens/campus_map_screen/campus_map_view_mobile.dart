import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view_mobile_state.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view_stateful.dart';
import 'package:provider/provider.dart';

class CampusMapViewMobileLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeModel>(
        builder: (context, themeModel, child) => CampusMapViewStateful(
          state: CampusMapViewMobileLandscapeState(themeModel: themeModel),
        ),
      ),
    );
  }
}

class CampusMapViewMobilePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ThemeModel>(
        builder: (context, themeModel, child) => CampusMapViewStateful(
          state: CampusMapViewMobilePortraitState(themeModel: themeModel),
        ),
      ),
    );
  }
}
