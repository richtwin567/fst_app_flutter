import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

class GeoJSONPoint extends GeoJSONGeometryObject {
  GeoJSONPosition _coordinates;

  GeoJSONPosition get coordinates => _coordinates;

  GeoJSONPoint({@required coordsJSON})
      : assert(coordsJSON != null),
        super(GeoJSONGeometryType.Point) {
    //print(coordsJSON[0]['longitude'] is double);
    _coordinates = GeoJSONPosition(
        newLongitude: coordsJSON[0]['longitude'],
        newLatitude: coordsJSON[0]['latitude']);
  }

  @override
  toGeoJSONFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.toGeoJSON()
    };
  }

  @override
  toGeoJSON() {
    return {
      'type': type.toShortString(),
      'coordinates': coordinates.toGeoJSON()
    };
  }

  @override
  extractLatLng() {
    return coordinates.extractLatLng();
  }
}
