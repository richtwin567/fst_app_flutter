import 'package:flutter/material.dart';
import 'package:fst_app_flutter/screens/contact_screen/django_requests/handle_contacts.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_detail_image.dart';
import 'package:fst_app_flutter/screens/contact_screen/pages/contact_detail_page.dart';
import 'package:fst_app_flutter/screens/contact_screen/local_widgets/contact_widgets.dart';

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
                      setState(() {
                        
                      });
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
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                      flex: 30,
                      child: FutureBuilder(
                        future: GetContacts.searchDjangoContacts(_currentValue),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.connectionState ==
                              ConnectionState.none) {
                            return Center(
                                child: Text(
                                    'Cannot load contacts. Check your internet connection.'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.hasData) {
                              _contacts = snapshot.data.toSet().toList();
                              return  _currentValue == ''
                                  ? _defaultView
                                  : buildContactListView(_contacts);
                            } else if (!snapshot.hasData &&
                                !snapshot.hasError) {
                              return Center(child: Text('No matches found'));
                            } else {
                              return Center(child: Text('An error occured'));
                            }
                          }
                          return Container();
                        },
                      ))
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
