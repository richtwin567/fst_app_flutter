import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_state.dart';

/// ContactViewState designed for tablets in portrait orientation.
/// Currently the same as the landscape state.
class ContactViewTabletPortraitState extends ContactViewTabletLandscapeState {
  ContactViewTabletPortraitState({@required ThemeModel themeModel})
      : super(themeModel: themeModel);
}

/// ContactViewState designed for tablets in landscape orientation.
class ContactViewTabletLandscapeState extends ContactViewState {
  /// The filterDrawer animation controller.
  AnimationController filterDrawerController;

  /// Sets the background colour of the non-selected filter options.
  Color filterOptionBgColor;

  ContactViewTabletLandscapeState({@required ThemeModel themeModel})
      : super(themeModel: themeModel);

  /// Also initialize [filterDrawerController] aside from the initialization done in
  /// [super.initState]
  @override
  void initState() {
    super.initState();
    filterDrawerController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    var screenHeight = mq.size.height;
    var screenWidth = mq.size.width;
    var sidepanelWidth = screenWidth * 0.25 + kMinInteractiveDimension;
    var topViewInsets = mq.padding.top;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: <Widget>[
          Stack(
            children: [
              buildMovingContactListArea(
                  titleStyle:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                  subtitleStyle:
                      TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                  posFromTop: kToolbarHeight + topViewInsets,
                  height: screenHeight - kToolbarHeight,
                  width: screenWidth - kMinInteractiveDimension,
                  padH: screenWidth * 0.07,
                  padV: screenHeight * 0.05,
                  posFromLeft: kMinInteractiveDimension,
                  posFromBottom: 0.0,
                  posFromRight: 0.0,
                  growBottom: 0.0,
                  growLeft: sidepanelWidth,
                  growRight: 0.0,
                  growTop: kToolbarHeight,
                  controller: filterDrawerController),
            ],
          ),
          Container(),
          filterDrawer(
              bgColor: themeModel.selectedTheme == ThemeMode.dark? ElevationOverlay.applyOverlay(context,Theme.of(context).primaryColor , 2.0) : Theme.of(context).accentColor,
              width: sidepanelWidth,
              height: screenHeight - kToolbarHeight,
              posFromTop: kToolbarHeight + topViewInsets),
          Container(),
          buildAppBarArea(
              height: kToolbarHeight + topViewInsets,
              animationIntervalStart: 0.0,
              animationIntervalEnd: 1.0,
              actions: <Widget>[],
              elevation: 4.0)
        ],
      ),
    );
  } // build

  /// Opens and closes the drawer while moving the list to make space.
  toggleDrawer() => filterDrawerController.isDismissed
      ? filterDrawerController.forward()
      : filterDrawerController.reverse();

  /// Builds each item for the list of filter options for the [filterDrawer].
  filterDrawerListBuilder(context, i, height) {
    return InkWell(
      onTap: () {
        setState(() {
          extraParam =
              '&${categories[i]['queryParam']}=${categories[i]['value']}';
          currentFilter = categories[i]['title'];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.01, top: height * 0.01),
        height: (height / categories.length) - ((height * 0.01) * 2),
        decoration: BoxDecoration(
            color: currentFilter == categories[i]['title']
                ? themeModel.selectedTheme == ThemeMode.dark? Theme.of(context).primaryColor : Color.lerp(Colors.blue[600], Colors.blue[700], 0.5)
                : filterOptionBgColor,
            borderRadius: BorderRadius.circular(40.0)),
        child: ListTile(
          title: Text(
            categories[i]['title'],
            softWrap: true,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  } // filterDrawerListBuilder

  /// Creates a collapsing drawer with the list of filter options by [categories].
  ///
  /// It has a specific [height], [width] and background colour, [bgColor]. It
  /// is [Positioned] [posFromTop] from the top of the screen.
  Widget filterDrawer({
    @required double width,
    @required double height,
    @required Color bgColor,
    @required double posFromTop,
  }) {
    return SlideTransition(
        position:
            Tween<Offset>(begin: Offset(-0.25, 0.0), end: Offset(0.0, 0.0))
                .animate(CurvedAnimation(
                    parent: filterDrawerController,
                    curve: Curves.elasticOut,
                    reverseCurve: Curves.elasticIn)),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: posFromTop,
              child: Container(
                color: bgColor,
                width: width,
                height: height,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      right: kMinInteractiveDimension, left: width * 0.05),
                  child: ListView.builder(
                    itemBuilder: (context, i) =>
                        filterDrawerListBuilder(context, i, height),
                    itemCount: categories.length,
                    semanticChildCount: categories.length,
                  ),
                ),
              ),
            ),
            Container(),
            Positioned(
              top: posFromTop,
              left: width - kMinInteractiveDimension,
              child: InkWell(
                onTap: () => toggleDrawer(),
                child: Container(
                    height: height,
                    width: kMinInteractiveDimension,
                    color: bgColor,
                    child: RotationTransition(
                      turns: Tween<double>(begin: 1.0, end: 0.5).animate(
                          CurvedAnimation(
                              parent: filterDrawerController,
                              curve: Interval(0.0, 0.4, curve: Curves.linear))),
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_right,
                              color: Colors.white,
                            ),
                            onPressed: () => toggleDrawer()),
                      ),
                    )),
              ),
            ),
            Container(),
          ],
        ));
  } // filterDrawer

}
