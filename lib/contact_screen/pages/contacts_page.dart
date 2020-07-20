import 'package:flutter/material.dart';
import 'package:fst_app_flutter/contact_screen/django_requests/get_contacts.dart';
import 'dart:convert';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final searchController = TextEditingController();
  List<dynamic> contacts = [];

  _ContactPageState() {
    searchDjangoContacts("");
  }

  searchDjangoContacts(value) async {
    GetContacts.getContactsDjangoApi(value).then((responseBody) {
      List<dynamic> data = jsonDecode(responseBody);
      setState(() {
        data.forEach((element) {
          contacts.add(element);
        });
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
                  contacts.clear();
                  if (value.isNotEmpty) {
                    searchDjangoContacts(value);
                  } else {
                    searchDjangoContacts("");
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
                child:Text(                
                contacts.length.toString() + ' contacts',
                textAlign: TextAlign.left,
              )),
              Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 30,
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildContactCard(contacts[index]);
                },
              ))
            ],
          )),
    );
  }

  Widget _buildContactCard(contactData) {
    String tel = '';
    for (var i = 0; i < contactData['phone_contact_set'].length; i++) {
      tel += contactData['phone_contact_set'][i]['phone'];
      tel += ', ';
    }
    return Container(
        
        margin: EdgeInsets.fromLTRB(2.0, 5.0, 2.0, 5.0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              blurRadius: 2.0,
              color: Colors.grey[350],
              offset: Offset(1.0, 1.0))
        ]),
        child: ListTile(
          /* onTap: Navigator.push(context, route), */
          title: Text(contactData['id'].toString() + ' ' + contactData['name']),
          subtitle: Text(contactData['description'] + ' ' + tel),
          trailing: Icon(Icons.chevron_right),
        ));
  }
}
