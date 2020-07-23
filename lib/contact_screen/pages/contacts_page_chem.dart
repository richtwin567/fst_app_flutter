import 'package:flutter/material.dart';
import 'package:fst_app_flutter/contact_screen/django_requests/handle_contacts.dart';
import 'package:fst_app_flutter/contact_screen/pages/contacts_page_general.dart';

class ChemContactPage extends StatefulWidget {
  @override
  _ChemContactPageState createState() => _ChemContactPageState();
}

class _ChemContactPageState extends State<ChemContactPage> {

  List<dynamic> contacts = [];

  _ChemContactPageState() {
    updateContactsList('');
  }

  updateContactsList(value) async {
    GetContacts.searchDjangoContacts(value).then((data) {
      setState(() {
        contacts.addAll(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chemistry Contacts'),
      ),
      body:  Container(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            verticalDirection: VerticalDirection.down,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  contacts.clear();
                  if (value.isNotEmpty) {
                    updateContactsList(value);
                  } else {
                    updateContactsList('');
                  }
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
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
                    contacts.length.toString() + ' contacts',
                    textAlign: TextAlign.left,
                  )),
              Spacer(
                flex: 1,
              ),
              Expanded(
                  flex: 30,
                  child:  ListView.builder(
                          shrinkWrap: true,
                          itemCount: contacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildContactListView(contacts);
                          },
                        ))
            ],
          )),
    );
  }
}
