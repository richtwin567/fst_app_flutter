import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/campus_map.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/feature_collection.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/properties.dart';
import 'package:fst_app_flutter/models/preferences/theme_model.dart';
import 'package:fst_app_flutter/screens/campus_map_screen/campus_map_view_stateful.dart';
import 'package:fst_app_flutter/utils/app_theme.dart';
import 'package:fst_app_flutter/utils/permissions.dart';
import 'package:fst_app_flutter/widgets/arrowed_tooltip.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fst_app_flutter/models/enums/department.dart';

class CampusMapViewState extends State<CampusMapViewStateful>
    with TickerProviderStateMixin {
  Set<Polygon> polygons = {};
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  Completer<GoogleMapController> _controller = Completer();

  final ThemeModel themeModel;

  Properties currentInfo;
  bool isFeatureSelected;
  Color appbarColor;
  Tween<double> sizeAnimation;
  ColorTween appBarOpacity;

  var leading;

  AnimationController dataWindowController;

  CampusMapViewState(this.themeModel);

  @override
  void initState() {
    super.initState();
    isFeatureSelected = false;
    currentInfo = Properties();
    leading = BackButton();
    sizeAnimation = Tween(begin: 0.0, end: 1.0);
    dataWindowController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    appBarOpacity = ColorTween(begin: AppTheme.getFromModel(themeModel).primaryColor.withAlpha(70), end: AppTheme.getFromModel(themeModel).primaryColor);
  }

  @override
  void dispose() {
    super.dispose();
    dataWindowController.dispose();
  }

  hideDataWindow() {
    if (dataWindowController.isCompleted) {
      dataWindowController.reverse();
    }
  }

  showDataWindow() {
    if (dataWindowController.isDismissed) {
      dataWindowController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    requestPermission(Permission.locationWhenInUse);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            FutureBuilder(
              future: insertMapFeatures(),
              builder: (context, snapshot) => GoogleMap(
                myLocationButtonEnabled: true,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight),
                buildingsEnabled: true,
                markers: markers,
                initialCameraPosition: CameraPosition(
                    target: LatLng(18.005208, -76.750198), zoom: 17.5),
                mapType: MapType.satellite,
                compassEnabled: true,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  _controller.complete(controller);
                  setState(() {});
                },
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: !isFeatureSelected,
                trafficEnabled: false,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: true,
                polygons: polygons,
                polylines: polylines,
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
                child:
                    /* Visibility(
                    visible: isFeatureSelected,
                    child:  */
                    AnimatedOpacity(
                  opacity: isFeatureSelected ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 800),
                  child: SizeTransition(
                    sizeFactor: sizeAnimation.animate(CurvedAnimation(
                        parent: dataWindowController, curve: Curves.ease)),
                    child: DataWindow(
                      properties: currentInfo,
                    ),
                  ),
                )),
            Container(
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              alignment: Alignment.center,
              child: AppBar(
                  automaticallyImplyLeading: false,
                  leading: isFeatureSelected
                      ? IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              isFeatureSelected = false;
                              hideDataWindow();
                            });
                          })
                      : BackButton(),
                  centerTitle: false,
                  title:
                      isFeatureSelected ? Text(currentInfo.title) : Text('Map'),
                  backgroundColor: appBarOpacity.evaluate(CurvedAnimation(parent: dataWindowController, curve: Curves.ease)),
            )),
          ],
        ));
  }

  insertMapFeatures() async {
    var features = await CampusMap.locations;
    polygons = extractPolygonsToGoogleMaps(features) ?? {};
    markers = extractPointsToGoogleMaps(features) ?? {};
    polylines = extractLineStringsToGoogleMaps(features) ?? {};
  }

  Set<Marker> extractPointsToGoogleMaps(FeatureCollection col) {
    return col.features
        .where((feature) => feature.geometry.type == GeoJsonGeometryType.point)
        .map((e) => Marker(
            flat: true,
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            onDragEnd: (value) {},
            markerId: MarkerId('${e.id}'),
            onTap: () {
              setState(() {
                currentInfo = e.properties;
                isFeatureSelected = true;
                showDataWindow();
              });
            },
            draggable: false,
            position: e.geometry.extractLatLng()[0],
            alpha: 0.8))
        .toSet();
  }

  Set<Polygon> extractPolygonsToGoogleMaps(FeatureCollection col) {
    return col.features
        .where(
            (feature) => feature.geometry.type == GeoJsonGeometryType.polygon)
        .map((e) => Polygon(
            polygonId: PolygonId('${e.id}'),
            fillColor:
                e.properties.associatedWith.departmentColour.withAlpha(70),
            strokeWidth: 1,
            strokeColor:
                e.properties.associatedWith.departmentColour.withAlpha(70),
            points: e.geometry.extractLatLng()))
        .toSet();
  }

  Set<Polyline> extractLineStringsToGoogleMaps(FeatureCollection col) {
    return col.features
        .where((feature) =>
            feature.geometry.type == GeoJsonGeometryType.lineString)
        .map((e) => Polyline(
              polylineId: PolylineId('${e.id}'),
              color: e.properties.associatedWith.departmentColour.withAlpha(90),
              jointType: JointType.round,
              endCap: Cap.roundCap,
              startCap: Cap.roundCap,
              width: 30,
              points: e.geometry.extractLatLng(),
            ))
        .toSet();
  }
}

class DataWindow extends StatefulWidget {
  final Properties properties;
  DataWindow({Key key, this.properties}) : super(key: key);

  @override
  DataWindowState createState() => DataWindowState();
}

class DataWindowState extends State<DataWindow> {
  Properties get properties => widget.properties;

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Container(
      height: (mq.size.height / 2) - mq.padding.top - 64.0,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: ListView(
          shrinkWrap: true,
          children: [
            properties?.description?.isEmpty ?? false
                ? Container()
                : ListTile(
                    title: Text('Description'),
                    subtitle: Text(properties?.description ?? ''),
                  ),
            properties?.altName?.isEmpty ?? false
                ? Container()
                : ListTile(
                    title: Text('Alternate name'),
                    subtitle: Text(properties?.altName ?? ''),
                  ),
          ],
        ),
        elevation: 2.0,
        shape: DownArrowTooltip(
            arrowHeight: MediaQuery.of(context).size.height * 0.04,
            arrowWidth: MediaQuery.of(context).size.width * 0.08),
        margin: EdgeInsets.zero,
      ),
    );
  }
}
