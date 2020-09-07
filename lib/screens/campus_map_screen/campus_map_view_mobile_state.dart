import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view_state.dart';
import 'package:fst_app_flutter/widgets/shape_borders/arrowed_tooltip.dart';

class CampusMapViewMobileLandscapeState extends CampusMapViewState {
  CampusMapViewMobileLandscapeState({@required ThemeModel themeModel})
      : super(themeModel);

  @override
  Widget build(BuildContext context) {
    var map = super.build(context);
    ArrowedTooltip shape = RightArrowTooltip(
        arrowLength: MediaQuery.of(context).size.width * 0.09,
        arrowWidth: MediaQuery.of(context).size.height * 0.05);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            map,
            buildPositionedDataWindow(context, shape),
            buildAppBar(context),
          ],
        ));
  }
}

class CampusMapViewMobilePortraitState extends CampusMapViewState {
  CampusMapViewMobilePortraitState({@required ThemeModel themeModel})
      : super(themeModel);

  @override
  Widget build(BuildContext context) {
    var map = super.build(context);
    ArrowedTooltip shape = DownArrowTooltip(
        arrowLength: MediaQuery.of(context).size.height * 0.04,
        arrowWidth: MediaQuery.of(context).size.width * 0.08);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            map,
            buildPositionedDataWindow(context, shape),
            buildAppBar(context),
          ],
        ));
  }
}
