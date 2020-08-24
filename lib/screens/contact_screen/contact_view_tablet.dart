import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_stateful.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_tablet_state.dart';
import 'package:provider/provider.dart';

/// Full portrait tablet contact view made using [ContactViewTabletPortraitState].
class ContactViewTabletPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ThemeModel>(builder: (context, theme, child) => ContactViewStateful(state: ContactViewTabletPortraitState(themeModel: theme))));
  }
}

/// Full landscape tablet landscape view made using [ContactViewTabletLandscapeState].
class ContactViewTabletLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<ThemeModel>(builder: (context, theme, child) => ContactViewStateful(state: ContactViewTabletLandscapeState(themeModel: theme))));
  }
}
