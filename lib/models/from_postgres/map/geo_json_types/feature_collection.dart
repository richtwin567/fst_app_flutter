import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/feature.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fst_app_flutter/models/enums/department.dart';

class FeatureCollection extends GeoJsonObject {
  List<Feature> features;
  FeatureCollection({@required this.features})
      : assert(features != null),
        super(GeoJsonType.featureCollection);

  @override
  String toGeoJsonFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"features\"': features.map((e) => e.toGeoJsonFile()).toList()
    }.toString();
  }

  @override
  Map<String, Object> toGeoJson() {
    return {
      'type': type.toShortString(),
      'features': features.map((e) => e.toGeoJson()).toList()
    };
  }

  Set<Marker> exportPointsToGoogleMaps() {
    return features
        .where((feature) => feature.geometry.type == GeoJsonGeometryType.point)
        .map((e) => Marker(
            onDragEnd: (value) {},
            markerId: MarkerId('${e.id}'),
            infoWindow: InfoWindow(
                snippet:
                    'Alternative name: ${e.properties.altName}\nDescription: ${e.properties.description}',
                title: e.properties.title),
            draggable: false,
            position: e.geometry.extractLatLng()[0],
            alpha: 0.8))
        .toSet();
  }

  Set<Polygon> exportPolygonsToGoogleMaps() {
    return features
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

  Set<Polyline> exportLineStringsToGoogleMaps() {
    return features
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


