import 'package:flutter/material.dart';
import 'package:fst_app_flutter/services/handle_heroku_requests.dart';
import 'package:fst_app_flutter/widgets/contact_tile.dart';
import 'package:fst_app_flutter/routing/routes.dart';
import 'contact_view_stateful.dart';

/// The base class for all contact view states for different screen sizes and orientations.
abstract class ContactViewState extends State<ContactViewStateful>
    with TickerProviderStateMixin {
  /// This [String] will be modified to include the search value entered by the user.
  /// Otherwise, it will be passed to the [getResultsJSON] like this.
  var baseParam = 'contact/?search=';

  /// Extra parameters to attach to the [baseParam] such as department or type.
  var extraParam = '';

  /// The default categories to filter by and their corresponding
  /// query parameter and value.
  ///
  /// Used to construct the [filterDropdown]
  final List<dynamic> categories = [
    {'title': 'All', 'queryParam': '', 'value': ''},
    {'title': 'Emergency', 'queryParam': 'type', 'value': 'EMERGENCY'},
    {
      'title': 'Chemistry Department',
      'queryParam': 'department',
      'value': 'CHEM'
    },
    {
      'title': 'Computing Department',
      'queryParam': 'department',
      'value': 'COMP'
    },
    {
      'title': 'Geography and Geology Department',
      'queryParam': 'department',
      'value': 'GEO'
    },
    {
      'title': 'Life Sciences Department',
      'queryParam': 'department',
      'value': 'LIFE'
    },
    {
      'title': 'Mathematics Department',
      'queryParam': 'department',
      'value': 'MATH'
    },
    {
      'title': 'Physics Department',
      'queryParam': 'department',
      'value': 'PHYS'
    },
    {
      'title': 'Faculty Wide Contacts',
      'queryParam': 'department',
      'value': 'OTHER'
    },
    {'title': 'Other Contacts', 'queryParam': 'type', 'value': 'OTHER'},
  ];

  /// a list to store all contacts that were a returned from the query
  List<dynamic> contacts = [];

  /// Currently selected dropdown item value. Allows for differential
  /// of text in the dropdown list for the item that is selected.
  String currentFilter = 'All';

  /// Used to switch the state of the appBar to a search field in the [revealSearchField]
  /// function.
  Icon searchIcon = Icon(Icons.search);

  /// Used to switch between filters from [categories] in the [filterDropdown]
  /// function
  Icon filterIcon = Icon(Icons.filter_list, color: Colors.white);

  /// Used to switch the state of the appBar to a search field in the [revealSearchField]
  /// function.
  Widget appBarTitle = Text('Contacts');

  /// Returns the list to the position it was at before navigatimg to another route.
  ScrollController sc = ScrollController(keepScrollOffset: true);

  /// Controller for dropdown sliding animation.
  AnimationController ac;

  /// Controls the search text field.
  TextEditingController tec;

  /// Color change sequence for app bar animation.
  Animatable<Color> appBarBgColor;

  /// Allows app bar leading icon to be removed and added in [revealSearchField]
  Widget appBarLeading = BackButton();

  AnimationController cc;

  AnimationController oc;

  /// Load all contacts when page is loaded initially. Initilize animations and controllers.
  @override
  void initState() {
    super.initState();
    getResultsJSON('$baseParam$extraParam')
        .then((data) => contacts = data.toSet().toList());
    ac = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    oc =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    appBarBgColor = TweenSequence([
      TweenSequenceItem(
          tween: ColorTween(
              begin: Color.fromRGBO(0, 62, 138, 1.0), end: Colors.blue[800]),
          weight: 1.0),
      TweenSequenceItem(
          tween: ColorTween(begin: Colors.blue[800], end: Colors.white),
          weight: 0.5)
    ]);
    cc =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    tec = TextEditingController();
    tec.addListener(() {
      setState(() {
        baseParam = 'contact/?search=${tec.value.text}';
        contacts.clear();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    sc.dispose();
    oc.dispose();
    ac.dispose();
    cc.dispose();
    tec.dispose();
  }

  /// Subclasses should implement
  @override
  Widget build(BuildContext context);

  /// Builds the app bar with specified [height], [elevation], [actions] and
  /// sets when [animationIntervalStart] and [animationIntervalEnd].
  Widget buildAppBarArea(
      {@required double height,
      @required double animationIntervalStart,
      @required double animationIntervalEnd,
      @required List<Widget> actions,
      @required double elevation}) {
    return AnimatedBuilder(
      animation: oc,
      builder: (BuildContext context, Widget child) {
        return StatefulBuilder(
          builder: (BuildContext context,
              void Function(void Function()) changeState) {
            return Container(
              height: height,
              child: AppBar(
                automaticallyImplyLeading: false,
                leading: appBarLeading,
                elevation: elevation,
                actions: [
                  ...actions,
                  IconButton(
                      icon: searchIcon,
                      onPressed: () {
                        changeState(() {
                          revealSearchField();
                        });
                      })
                ],
                centerTitle: false,
                backgroundColor: appBarBgColor
                    .evaluate(CurvedAnimation(parent: oc, curve: Curves.ease)),
                title: appBarTitle,
              ),
            );
          },
        );
      },
    );
  } // buildAppBarArea

  /// Builds a [Positioned] [filterDropdown].
  ///
  /// The distance from the top of the screen will be [posFromTop].
  ///
  /// The drop down will be [height] tall and [width] wide.
  ///
  /// It will have an [elevation] and the space the drop down
  /// uses will be determined by whether or not it [isExpanded].
  ///
  /// [slideDist] controls the sliding animation distance when [revealSearchField]
  /// is called by tapping [searchButton].
  Widget buildFilterDropdownArea(BuildContext context,
      {@required double posFromTop,
      @required double height,
      @required double width,
      @required bool isExpanded,
      @required double elevation}) {
    return Positioned(
        top: posFromTop,
        child: filterDropdown(
          context,
          height: height,
          width: width,
          isExpanded: isExpanded,
          elevation: elevation,
        ));
  } // buildFilterDropdownArea

  /// Builds a [Positioned] contact list using [contactFutureBuilder].
  ///
  /// The list will be a distance of [posFromTop] from the top of the screen and
  /// [posFromLeft] from the left of the screen.
  ///
  /// It will have a height of [height] and a width of [width].
  ///
  /// The amount of padding on the left and right will be [padH] and the padding
  /// at the top and bottom will be [padV].
  ///
  /// The title on each [ContactTile] will have a [titleStyle] and the subtitle
  /// will have a [subtitleStyle].
  ///
  /// The line between each [ContactTile] will be [thickness] in width.
  ///
  /// The distance for the animation is controlled by [begin] and [end].
  Widget buildContactListAreaMoving(
      {
      @required double posFromTop,
      @required double posFromLeft,
      @required double posFromRight,
      @required double posFromBottom,
      @required double growTop,
      @required double growLeft,
      @required double growRight,
      @required double growBottom,
      @required AnimationController controller,
      @required double height,
      @required double width,
      @required double padH,
      @required double padV,      
      @required double thickness,
      TextStyle titleStyle,
      TextStyle subtitleStyle,
      bool isDecorated = true}) {
    return PositionedTransition(
        rect: RelativeRectTween(
                begin: RelativeRect.fromLTRB(posFromLeft, posFromTop, posFromRight, posFromBottom),
                end: RelativeRect.fromLTRB( growLeft, growTop,  growRight,  growBottom))
            .animate(CurvedAnimation(parent: controller, curve: Curves.ease)),
        child: contactFutureBuilder(
          isDecorated: isDecorated,
          thickness: thickness,
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
          height: height,
          padH: padH,
          padV: padV,
          width: width,
        ));
  } // buildContactListArea

  Widget buildContactListAreaStatic(
      {@required double posFromTop,
      @required double height,
      @required double width,
      @required double padH,
      @required double padV,
      @required posFromLeft,
      @required thickness,
      TextStyle titleStyle,
      TextStyle subtitleStyle,
      bool isDecorated = true}) {
    return Positioned(
        top: posFromTop,
        left: posFromLeft,
        child: contactFutureBuilder(
          isDecorated: isDecorated,
          thickness: thickness,
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
          height: height,
          padH: padH,
          padV: padV,
          width: width,
        ));
  } // build

  /// Builds the Search [IconButton] that goes in the [AppBar] actions.
  Widget searchButton() {
    return IconButton(icon: searchIcon, onPressed: revealSearchField);
  }

  /// Toggle appbar and dropdown button animations
  toggleFilterDropdownAnimation() =>
      cc.isDismissed ? cc.forward() : cc.reverse();

  toggleAppBarAnimation() => oc.isDismissed ? oc.forward() : oc.reverse();

  /// Toggles the [AppBar] between the page title and the search [TextField]
  void revealSearchField() {
    toggleFilterDropdownAnimation();
    toggleAppBarAnimation();
    appBarLeading = null;
    if (searchIcon.icon == Icons.search) {
      searchIcon = Icon(
        Icons.close,
        color: Colors.black45,
      );
      filterIcon = Icon(
        Icons.filter_list,
        color: Colors.white,
      );
      appBarTitle = TextField(
        controller: tec,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search),
            hintText: 'Search',
            filled: false,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            )),
      );
    } else {
      appBarLeading = BackButton();
      searchIcon = Icon(
        Icons.search,
        color: Colors.white,
      );
      appBarTitle = Text('Contacts');
      filterIcon = Icon(
        Icons.filter_list,
        color: Colors.white,
      );
      baseParam = 'contact/?search=';
      contacts.clear();
      tec.clear();
    }
  } // revealSearchField

  /// Builds a [ListView] of [ContactTile] for each member
  /// in the list of [contacts].
  Widget buildContactListView(
      {@required List<dynamic> contacts,
      bool hasDecoration,
      @required double thickness,
      TextStyle subtitleStyle,
      TextStyle titleStyle}) {
    return Scrollbar(
      controller: sc,
      child: ListView.builder(
          itemCount: contacts.length,
          semanticChildCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            return ContactTile(
              subtitleStyle: subtitleStyle,
              hasDecoration: hasDecoration,
              titleStyle: titleStyle,
              title: contacts[index]['name'],
              subtitle: contacts[index]['description'],
              namedRoute: contactDetailRoute,
              arguments: contacts[index],
              thickness: thickness,
            );
          }),
    );
  } // buildContactCard

  /// Displays a [CircularProgressIndicator] while the list of contacts loads.
  /// Also displays message indicating that no matches were found if
  /// no matches were found and a message if an error occured.
  Widget contactFutureBuilder(
      {@required bool isDecorated,
      @required double thickness,
      @required double padH,
      @required double padV,
      @required double height,
      @required double width,
      TextStyle subtitleStyle,
      TextStyle titleStyle}) {
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.fromLTRB(padH, padV, padH, padV),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                  child: FutureBuilder(
                future: getResultsJSON('$baseParam$extraParam'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Center(
                        child: Text(
                            'Cannot load contacts. Check your internet connection.'));
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      contacts = snapshot.data.toSet().toList();
                      if (contacts.length > 0) {
                        return buildContactListView(
                            titleStyle: titleStyle,
                            subtitleStyle: subtitleStyle,
                            contacts: contacts,
                            hasDecoration: isDecorated,
                            thickness: thickness);
                      } else {
                        return Center(child: Text('No matches found'));
                      }
                    } else if (!snapshot.hasData || snapshot.hasError) {
                      return Center(child: Text('An error occured'));
                    } else {
                      return Center(child: Text('No matches found'));
                    }
                  }
                  return Container();
                },
              ))
            ]));
  } // _contactFutureBuilder

  /// Drop down button to filter the list of [contacts] by [categories].
  filterDropdown(BuildContext context,
      {@required double height,
      @required double width,
      @required bool isExpanded,
      @required double elevation}) {
    return SlideTransition(
        position: Tween<Offset>(begin: Offset(0.0, 0.0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(parent: cc, curve: Curves.ease)),
        child: Card(
            margin: EdgeInsets.all(0.0),
            elevation: elevation,
            child: PreferredSize(
                child: Container(
                    color: Theme.of(context).accentColor,
                    height: height,
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          selectedItemBuilder: (context) {
                            return categories
                                .map((e) => Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(e['title'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600)),
                                    ))
                                .toList();
                          },
                          isExpanded: isExpanded,
                          icon: filterIcon,
                          value: currentFilter,
                          items:
                              filterDropDownItemBuilder(context, width: width),
                          onChanged: (value) {
                            currentFilter = value;
                          }),
                    )),
                preferredSize: Size.fromHeight(height))));
  }

  /// Builds the  dropdown list for [filterDropdown] from [categories].
  List<DropdownMenuItem<dynamic>> filterDropDownItemBuilder(context,
      {@required double width}) {
    return List.generate(categories.length, (i) {
      return DropdownMenuItem(
        child: Container(
          alignment: Alignment.centerLeft,
          height: kMinInteractiveDimension,
          width: width,
          child: Text(
            categories[i]['title'],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: categories[i]['title'] == currentFilter
                ? TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w800)
                : null,
          ),
        ),
        onTap: () {
          /* setState(
            () {
              extraParam =
                  '&${categories[i]['queryParam']}=${categories[i]['value']}';
            },
          ); */
        },
        value: categories[i]['title'],
      );
    });
  }
} // _ContactPageState
