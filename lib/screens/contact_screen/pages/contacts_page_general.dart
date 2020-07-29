import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/django_requests/handle_contacts.dart';
import 'package:fst_app_flutter/screens/contact_screen/pages/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_widgets.dart';

class ContactPage extends StatefulWidget {
  static const routeName = '/contact';

  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
} // ContactPage definition

class _ContactPageState extends State<ContactPage> {
  var _currentValue = 'search=';
  var _extraParam = '';

  Chip _filterChips;
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

  List<dynamic> _contacts = [];

  @override
  void initState() {
    GetContacts.searchDjangoContacts('$_currentValue$_extraParam')
        .then((data) => _contacts = data.toSet().toList());
    super.initState();
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
            _filterChips = Chip(
              deleteIcon:
                  Icon(Icons.cancel, color: Theme.of(context).primaryColor),
              label: Text(_categories[index]['title']),
              onDeleted: () {
                setState(() {
                  _extraParam = '';
                  _filterChips = null;
                });
              },
            );
          });
        },
      );
    }));

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
        body: mq.orientation == Orientation.portrait? Container(
            height: mq.size.height,
            width: mq.size.width,
            padding: EdgeInsets.fromLTRB(conPadW, conPadH, conPadW, conPadH),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: mq.size.height,
                    minWidth: mq.size.width,
                    maxHeight: mq.size.height,
                    maxWidth: mq.size.width ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                          flex: flexTField,
                          child: TextField(
                            onChanged: (value) {
                              _currentValue = 'search=$value';
                              _contacts.clear();
                              setState(() {});
                            },
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.search),
                                contentPadding:
                                    EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                                hintText: 'Search',
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0)),
                                  borderSide: BorderSide.none,
                                )),
                          )),
                      Flexible(
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: _filterChips,
                          ),
                          flex: flexChip),
                      Expanded(
                          flex: flexList,
                          child: FutureBuilder(
                            future: GetContacts.searchDjangoContacts(
                                '$_currentValue$_extraParam'),
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
                                  _contacts = snapshot.data.toSet().toList();
                                  if (_contacts.length > 0) {
                                    return _currentValue == 'search=' &&
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
            )):
            Container()
            
            );
  }
} // _ContactPageState

/// Builds a contact list view for the specified contacts
/// [contacts] the list of contacts
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
