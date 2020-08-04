import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_state.dart';

/// [ContactViewState] designed for phones in landscape orientation.
class ContactViewMobileLandscapeState extends ContactViewState {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);

    return Scaffold(
        body: SafeArea(
            child: AnimatedBuilder(
                animation: ac,
                builder: (context, child) => Stack(
                      children: <Widget>[
                        Container(),
                        buildContactListArea(
                          posFromTop: kToolbarHeight,
                          slideDist: 0.0,
                          height: mq.size.height - kToolbarHeight,
                          width: mq.size.width,
                          padH: mq.size.width * 0.05,
                          padV: mq.size.height * 0.05,
                          posFromLeft: 0.0,
                          thickness: 1.0,
                        ),
                        Container(),
                        buildAppBarArea(
                            height: kToolbarHeight,
                            animationIntervalStart: 0.0,
                            animationIntervalEnd: 1.0,
                            actions: <Widget>[
                              filterDropdown(context,
                                  height: kToolbarHeight,
                                  width: mq.size.width / 3,
                                  isExpanded: true,
                                  slideDist: -kToolbarHeight * ac.value,
                                  elevation: 0.0),
                              searchButton()
                            ],
                            elevation: 4.0),
                      ],
                    ))));
  }
}

/// [ContactViewState] designed for phones in portrait orientation.
class ContactViewMobilePortraitState extends ContactViewState {
  @override
  Widget build(BuildContext context) {
    // width and height calculations made using the [MediaQueryData]
    var mq = MediaQuery.of(context);
    // horizontal and vertical padding for the list of contacts
    var padH = mq.size.width * 0.1;
    var padV = (mq.size.height - (kToolbarHeight * 2)) * 0.07;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: AnimatedBuilder(
        animation: ac,
        builder: (context, child) => Stack(
          children: <Widget>[
            Container(),
            buildContactListArea(
              slideDist: -kToolbarHeight * ac.value,
              height: mq.size.height - (kToolbarHeight * 2),
              padH: padH,
              padV: padV,
              width: mq.size.width,
              posFromTop: kToolbarHeight * 2,
              posFromLeft: 0.0,
              thickness: 1.0,
            ),
            buildFilterDropdownArea(context,
                posFromTop: kToolbarHeight,
                slideDist: -kToolbarHeight * ac.value,
                width: MediaQuery.of(context).size.width,
                height: kToolbarHeight,
                isExpanded: true,
                elevation: 4.0),
            buildAppBarArea(
                height: kToolbarHeight,
                animationIntervalStart: 0.40,
                animationIntervalEnd: 1.0,
                actions: <Widget>[searchButton()],
                elevation: 0.0),
          ],
        ),
      )),
    );
  }
}
