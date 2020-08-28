import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_state.dart';

/// [ContactViewState] designed for phones in landscape orientation.
class ContactViewMobileLandscapeState extends ContactViewState {
  ContactViewMobileLandscapeState({@required ThemeModel themeModel})
      : super(themeModel: themeModel);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var topViewInsets = mq.padding.top;

    return Scaffold(
        //backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
      children: <Widget>[
        Container(),
        buildFixedContactListArea(
          posFromTop: kToolbarHeight + topViewInsets,
          height: mq.size.height - kToolbarHeight - topViewInsets,
          width: mq.size.width,
          padH: mq.size.width * 0.05,
          padV: mq.size.height * 0.05,
          posFromLeft: 0.0,
        ),
        Container(),
        buildAppBarArea(
            height: kToolbarHeight+topViewInsets,
            animationIntervalStart: 0.0,
            animationIntervalEnd: 1.0,
            actions: <Widget>[
              filterDropdown(context,
                  height: kToolbarHeight+topViewInsets,
                  width: mq.size.width / 3,
                  isExpanded: true,
                  elevation: 0.0),
            ],
            elevation: 4.0),
      ],
    ));
  }
}

/// [ContactViewState] designed for phones in portrait orientation.
class ContactViewMobilePortraitState extends ContactViewState {
  ContactViewMobilePortraitState({@required ThemeModel themeModel})
      : super(themeModel: themeModel);

  @override
  Widget build(BuildContext context) {
    // width and height calculations made using the [MediaQueryData]
    var mq = MediaQuery.of(context);
    // horizontal and vertical padding for the list of contacts
    var padH = mq.size.width * 0.1;
    var padV = (mq.size.height - (kToolbarHeight * 2)) * 0.07;
    var topViewInsets = mq.padding.top;

    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          Container(),
          buildMovingContactListArea(
            height: mq.size.height - (kToolbarHeight * 2),
            padH: padH,
            padV: padV,
            width: mq.size.width,
            posFromTop: kToolbarHeight * 2 + topViewInsets,
            posFromLeft: 0.0,
            growLeft: 0.0,
            growTop: (kToolbarHeight * 2) * 0.5,
            growBottom: 0.0,
            growRight: 0.0,
            posFromBottom: 0.0,
            posFromRight: 0.0,
            controller: dropdownController,
          ),
          buildFilterDropdownArea(context,
              posFromTop: kToolbarHeight + topViewInsets,
              width: MediaQuery.of(context).size.width,
              height: kToolbarHeight,
              isExpanded: true,
              elevation: 4.0),
          buildAppBarArea(
              height: kToolbarHeight + topViewInsets,
              animationIntervalStart: 0.40,
              animationIntervalEnd: 1.0,
              actions: <Widget>[],
              elevation: 0.0),
        ],
      ),
    );
  }
}
