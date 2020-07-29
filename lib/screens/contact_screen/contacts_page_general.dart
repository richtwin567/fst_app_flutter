import 'package:flutter/material.dart';
import 'package:fst_app_flutter/services/handle_heroku_requests.dart';
import 'package:fst_app_flutter/screens/contact_screen/contact_detail_page.dart';
import 'package:fst_app_flutter/widgets/contact_tile.dart';

class ContactPage extends StatefulWidget {
  static const routeName = '/contact';

  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
} // ContactPage definition

class _ContactPageState extends State<ContactPage> {
  /// This [String] will be modified to include the search value entered by the user.
  /// Otherwise, it will be passed to the `getResultsJSON` like this.
  var _baseParam = 'contact/?search=';

  /// Extra parameters to attach to the [_baseParam] such as department or type.
  var _extraParam = '';

  /// A chip that will allow users to toggle department/type filters
  Chip _filterChip;

  /// The default categories to filter by and their corresponding
  /// query parameter and value.
  ///
  /// Used to construct the [defaultListView]
  final List<dynamic> _categories = [
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
  List<dynamic> _contacts = [];

  /// Used to switch the state of the appBar to a search field in the `revaelSearchField`
  /// function.
  Icon _searchIcon = Icon(Icons.search);

  /// Used to switch the state of the appBar to a search field in the `revaelSearchField`
  /// function.
  Widget _appBarTitle = Text('Contacts');

  /// Controls what happens when th user switches between tabs.
  TabController _tabController;

  /// Load all contacts when page is loaded initially
  @override
  void initState() {
    HandleHerokuRequests.getResultsJSON('$_baseParam$_extraParam')
        .then((data) => _contacts = data.toSet().toList());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ListView _defaultView = ListView(
        children: List<Widget>.generate(_categories.length, (index) {
      return ContactTile(
        title: _categories[index]['title'],
        subtitle: 'See related contacts',
        namedRoute: null,
        tapFunc: () {
          setState(() {
            var queryParam = _categories[index]['queryParam'];
            var value = _categories[index]['value'];
            _extraParam = '&$queryParam=$value';
            _filterChip = Chip(
              deleteIcon:
                  Icon(Icons.cancel, color: Theme.of(context).primaryColor),
              label: Text(_categories[index]['title']),
              onDeleted: () {
                setState(() {
                  _extraParam = '';
                  _filterChip = null;
                });
              },
            );
          });
        },
        );
    }));

    // width and height calculations made using the [MediaQueryData]
    var mq = MediaQuery.of(context);
    var conPadW = mq.size.width * 0.07;
    var conPadH = mq.size.height * 0.03;
    var flexTField = (mq.size.height * 0.08).round();
    var flexChip = (mq.size.height * 0.05).round();
    var flexList = (mq.size.height * 0.7).round();
    var flexSpace = (mq.size.height * 0.1).round();

    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: mq.orientation == Orientation.portrait
            ? Container(
                height: mq.size.height,
                width: mq.size.width,
                padding:
                    EdgeInsets.fromLTRB(conPadW, conPadH, conPadW, conPadH),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: mq.size.height,
                        minWidth: mq.size.width,
                        maxHeight: mq.size.height,
                        maxWidth: mq.size.width),
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                        verticalDirection: VerticalDirection.down,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: _filterChip,
                                  ),
                                  flex: flexChip),
                              Expanded(
                                  flex: flexList,
                                  child: FutureBuilder(
                                    future: HandleHerokuRequests.getResultsJSON(
                                        '$_baseParam$_extraParam'),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.none) {
                                        return Center(
                                            child: Text(
                                                'Cannot load contacts. Check your internet connection.'));
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          _contacts =
                                              snapshot.data.toSet().toList();
                                          if (_contacts.length > 0) {
                                            return _baseParam ==
                                                        'contact/?search=' &&
                                                    _extraParam == ''
                                            ? _defaultView
                                            : buildContactListView(_contacts);
                                      } else {
                                        return Center(
                                            child: Text('No matches found'));
                                      }
                                    } else if (!snapshot.hasData ||
                                        snapshot.hasError) {
                                      return Center(
                                          child: Text('An error occured'));
                                    } else {
                                      return Center(
                                          child: Text('No matches found'));
                                    }
                                  }
                                  return Container();
                                },
                              ))
                        ]),
                  ),
                ))
                : Container(),
                    );
  }

  void _revealSearchField() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = Icon(Icons.close);
        _appBarTitle = TextField(
          onChanged: (value) {
            _baseParam = 'contact/?search=$value';
            _contacts.clear();
            setState(() {});
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
              hintText: 'Search',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide.none,
              )),
        );
      } else {
        _searchIcon = Icon(Icons.search);
        _appBarTitle = Text('Contacts');
      }
    });
  }
} // _ContactPageState

/// Builds a [ListView] of [ContactTile] for each member
/// in the list of [contacts].
Widget buildContactListView(List<dynamic> contacts) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: contacts.length,
      semanticChildCount: contacts.length,
      itemBuilder: (BuildContext context, int index) {
        return ContactTile(
            title: contacts[index]['name'],
            subtitle: contacts[index]['description'],
            namedRoute: ContactDetailPage.routeName,
            arguments: contacts[index]);
      });
} // buildContactCard
