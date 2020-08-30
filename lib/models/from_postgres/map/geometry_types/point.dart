import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

class GeoJsonPoint extends GeoJsonGeometryObject {
  GeoJsonPosition _coordinates;

  GeoJsonPosition get coordinates => _coordinates;

  GeoJsonPoint({@required coordsJson})
      : assert(coordsJson != null),
        super(GeoJsonGeometryType.point) {
    //print(coordsJSON[0]['longitude'] is double);
    _coordinates = GeoJsonPosition(
        newLongitude: coordsJson[0]['longitude'],
        newLatitude: coordsJson[0]['latitude']);
  }

  @override
  toGeoJsonFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.toGeoJson()
    };
  }

  @override
  toGeoJson() {
    return {
      'type': type.toShortString(),
      'coordinates': coordinates.toGeoJson()
    };
  }

  @override
  extractLatLng() {
    return coordinates.extractLatLng();
  }
}
