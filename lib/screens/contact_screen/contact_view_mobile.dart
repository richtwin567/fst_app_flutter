import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_mobile_state.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_stateful.dart';

/// Full mobile portrait contact view made using [ContactViewMobilePortraitState].
class ContactViewMobilePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ContactViewStateful(state: ContactViewMobilePortraitState()));
  }
}

/// Full mobile landscape contact view made using [ContactViewMobileLandscapeState].
class ContactViewMobileLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ContactViewStateful(state: ContactViewMobileLandscapeState()));
  }
}
