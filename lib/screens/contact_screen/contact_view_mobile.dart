import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/contact_view_model.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_mobile_state.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_view_stateful.dart';
import 'package:fst_app_flutter/widgets/base_data_model_widget.dart';

/// Full mobile portrait contact view made using [ContactViewMobilePortraitState].
class ContactViewMobilePortrait extends BaseModelWidget<ContactViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, ContactViewModel model) {
    return Scaffold(
        key: _scaffoldKey,
        body: ContactViewStateful(state: ContactViewMobilePortraitState()));
  }
}

/// Full mobile landscape contact view made using [ContactViewMobileLandscapeState].
class ContactViewMobileLandscape extends BaseModelWidget<ContactViewModel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, ContactViewModel model) {
    return Scaffold(
      key: _scaffoldKey,
      body: ContactViewStateful(state: ContactViewMobileLandscapeState()),
    );
  }
}
