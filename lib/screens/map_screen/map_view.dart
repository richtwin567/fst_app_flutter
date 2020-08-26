import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/campus_map.dart';
import 'dart:developer';

class CampusMapView extends StatefulWidget {
  @override
  _CampusMapViewState createState() => _CampusMapViewState();
}

showloc() async {
  log((await CampusMap.locations).toGeoJSON().toString());
}

class _CampusMapViewState extends State<CampusMapView> {
  @override
  Widget build(BuildContext context) {
    showloc();
    print({
      'test': ['1', '2', '3', '4']
    });
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Map'),
      ),
    );
  }
}
