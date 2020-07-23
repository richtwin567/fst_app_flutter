import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/django_requests/handle_contacts.dart';
import 'package:fst_app_flutter/screens/contact_screen/pages/contact_detail_page.dart';

/// Makes a container that gives the child widget a card like background
class ContactCard extends Container {
  /// [child] required widget that should go inside the card
  final Widget child;

  /// [margin] the space around the contact card
  ///
  /// default if no margin is specified:
  ///
  /// * this.margin = const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0)
  final EdgeInsetsGeometry margin;

  /// [padding] the space inside the card between the child and the edge of the card
  final EdgeInsetsGeometry padding;

  /// [height] the height of the child
  final double height;

  /// Creates a Contact card
  ///
  /// [child] required widget that should go inside the card.
  ///
  /// [height] the height of the child
  ///
  /// [margin] the space around the contact card
  ///
  /// [padding] the space inside the card between the child and the edge
  ///           of the card
  ContactCard(
      {Key key,
      @required this.child,
      this.height,
      this.margin = const EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
      this.padding})
      : super(
            key: key,
            child: child,
            height: height,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  blurRadius: 2.0,
                  color: Colors.grey[350],
                  offset: Offset(1.0, 1.0))
            ]));
} // ContactCard defintion

/// Makes a ListTile wrapped in a Container with the appropriate styling and
/// allows navigation to new pages
class ContactTile extends StatelessWidget {
  ///[title]  the required title of the list tile
  final String title;

  ///[subtitle] for the list tile
  final String subtitle;

  ///[namedRoute] the page that the Navigator should push when the tile is tapped.
  ///Must be a named route.
  final String namedRoute;

  ///[arguments] the data to be passed to the next page when the tile is tapped
  final dynamic arguments;

  ///Creates a contact tile
  ///
  ///[title]  the title of the list tile
  ///
  ///[subtitle] for the list tile
  ///
  ///[namedRoute] the page that the Navigator should push when the tile is tapped.
  ///Must be a named route.
  ///
  ///[arguments] the data to be passed to the next page when the tile is tapped
  ContactTile(
      {Key key,
      @required this.title,
      @required this.subtitle,
      @required this.namedRoute,
      this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContactCard(
        height: 90.0,
        child: ListTile(
          contentPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
          onTap: () {
            arguments != null
                ? Navigator.pushNamed(context, namedRoute, arguments: arguments)
                : Navigator.pushNamed(context, namedRoute);
          },
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Icons.chevron_right),
        ));
  }
} // ContactTile definition

class ContactPage extends StatefulWidget {
  static const routeName = '/contact';

  const ContactPage({Key key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
} // ContactPage definition

class _ContactPageState extends State<ContactPage> {
  var _currentValue = '';
  static final List<String> _categories = [
    'Emergency',
    'Chemistry Department',
    'Computing Department',
    'Geography and Geology Department',
    'Life Sciences Department',
    'Mathematics Department',
    'Physics Department',
    'Other Contacts'
  ];

  final ListView _defaultView = ListView(
      children: List<Widget>.generate(_categories.length, (index) {
    return ContactTile(
        title: _categories[index],
        subtitle: 'See related contacts',
        namedRoute: null);
  }));

  List<dynamic> _contacts = [];

  _ContactPageState() {
    _updateContactsList('');
  }

  _updateContactsList(value) async {
    GetContacts.searchDjangoContacts(value).then((data) {
      setState(() {
        _contacts.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.down,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextField(
                    onChanged: (value) {
                      _currentValue = value;
                      _contacts.clear();
                      if (value.isNotEmpty) {
                        _updateContactsList(value);
                      } else {
                        _updateContactsList('');
                      }
                    },
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        contentPadding:
                            EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                          borderSide: BorderSide.none,
                        )),
                  ),
                  Flexible(
                      flex: 3,
                      child: Text(
                        _contacts.length.toString() + ' contacts',
                        textAlign: TextAlign.left,
                      )),
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                      flex: 30,
                      child: _currentValue == ''
                          ? _defaultView
                          : buildContactListView(_contacts))
                ])));
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
            title: contacts[index]['id'].toString() +
                ' ' +
                contacts[index]['name'],
            subtitle: contacts[index]['description'],
            namedRoute: ContactDetailPage.routeName,
            arguments: contacts[index]);
      });
} // buildContactCard
