import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/feature.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geo_json_types/geo_json_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:fst_app_flutter/models/enums/department.dart';

class FeatureCollection extends GeoJSONObject {
  List<Feature> features;
  FeatureCollection({@required this.features})
      : assert(features != null),
        super(GeoJSONType.FeatureCollection);

  @override
  String toGeoJSONFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"features\"': features.map((e) => e.toGeoJSONFile()).toList()
    }.toString();
  }

  @override
  Map<String, Object> toGeoJSON() {
    return {
      'type': type.toShortString(),
      'features': features.map((e) => e.toGeoJSON()).toList()
    };
  }

  Set<Marker> exportPointsToGoogleMaps() {
    return features
        .where((feature) => feature.geometry.type == GeoJSONGeometryType.Point)
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
            (feature) => feature.geometry.type == GeoJSONGeometryType.Polygon)
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
            feature.geometry.type == GeoJSONGeometryType.LineString)
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


