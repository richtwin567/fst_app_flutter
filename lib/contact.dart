import 'package:flutter/material.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final searchController = TextEditingController();

  void initState() {
    super.initState();

    searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Contacts'),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextField(
                controller: searchController,
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
              ListView.builder(
                itemBuilder: (BuildContext context, int index) { 

                 },
                
              )
            ],
          ),
        ));
  }

  void _filterContacts() {}

  Widget _addContact(){}
}
