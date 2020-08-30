import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/campus_map.dart';
import 'package:fst_app_flutter/utils/permissions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class CampusMapView extends StatefulWidget {
  @override
  _CampusMapViewState createState() => _CampusMapViewState();
}

GlobalKey<DataWindowState> datawinkey = GlobalKey();

class _CampusMapViewState extends State<CampusMapView> {
  Set<Polygon> polygons = {};
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Completer<GoogleMapController> _controller = Completer();

  double zoom = 13.0;

  var future;
  var padding;

  @override
  void initState() {
    super.initState();
    future = insertMapFeatures();
    padding = EdgeInsets.zero;
  }

  @override
  Widget build(BuildContext context) {
    requestPermission(Permission.locationWhenInUse);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            centerTitle: false,
            title: Text('Map'),
            backgroundColor: Theme.of(context).primaryColor.withAlpha(70)),
        body: FutureBuilder(
          future: future,
          builder: (context, snapshot) => GoogleMap(
            padding: padding,
            buildingsEnabled: true,
            markers: markers,
            initialCameraPosition: CameraPosition(
                target: LatLng(18.005208, -76.750198), zoom: 17.5),
            mapType: MapType.satellite,
            compassEnabled: true,
            myLocationEnabled: true,
            onMapCreated: (controller) {
              _controller.complete(controller);
              setState(() {
                padding = EdgeInsets.only(
                    top: 
                        MediaQuery.of(context).padding.top);
              });
            },
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            trafficEnabled: false,
            zoomGesturesEnabled: true,
            mapToolbarEnabled: true,
            polygons: polygons,
            polylines: polylines,
          ),
        ));
  }

  insertMapFeatures() async {
    var features = await CampusMap.locations;
    polygons = features.exportPolygonsToGoogleMaps() ?? {};
    markers = features.exportPointsToGoogleMaps() ?? {};
    polylines = features.exportLineStringsToGoogleMaps() ?? {};
  }
}

class DataWindow extends StatefulWidget {
  DataWindow({Key key}) : super(key: key);

  @override
  DataWindowState createState() => DataWindowState();
}

class DataWindowState extends State<DataWindow> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
