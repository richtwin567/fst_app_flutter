import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

// TODO: document @richtwin567
class GeoJsonPoint extends GeoJsonGeometryObject {
  GeoJsonPosition _coordinates;

  GeoJsonPosition get coordinates => _coordinates;

  GeoJsonPoint({@required coordsJson})
      : assert(coordsJson != null),
        super(GeoJsonGeometryType.point) {
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
