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

class _CampusMapViewState extends State<CampusMapView> {
  Set<Polygon> polygons = {};
  Set<Marker> markers = {};
  Completer<GoogleMapController> _controller = Completer();

  double zoom = 13.0;

  @override
  Widget build(BuildContext context) {
    requestPermission(Permission.locationWhenInUse);
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: false,
          title: Text('Map'),
          backgroundColor: Theme.of(context).primaryColor.withAlpha(70)
        ),
        body: FutureBuilder(
          future:insertMapFeatures(),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GoogleMap(
                    buildingsEnabled: true,
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(18.005208, -76.750198), zoom: 17.0),
                    mapType: MapType.satellite,
                    compassEnabled: true,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      
                      _controller.complete(controller);
                    },
                    rotateGesturesEnabled: true,
                    scrollGesturesEnabled: true,
                    trafficEnabled: false,
                    zoomGesturesEnabled: true,
                    mapToolbarEnabled: true,
polygons: polygons,                  );
          },
        ));
  }

  insertMapFeatures() async {
    var features = await CampusMap.locations;
    polygons = features.exportPolygonsToGoogleMaps() ?? {};
    print(polygons);
    print(polygons.runtimeType);
    markers = features.exportPointsToGoogleMaps() ?? {};
  }
}
