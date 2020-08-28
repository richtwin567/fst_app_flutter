import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

class GeoJSONLineString extends GeoJSONGeometryObject {
  List<GeoJSONPosition> _coordinates;

  List<GeoJSONPosition> get coordinates => _coordinates;

  GeoJSONLineString({@required coordsJSON})
      : assert(coordsJSON != null),
        assert(coordsJSON.length >= 2),
        super(GeoJSONGeometryType.LineString) {
    _coordinates = List.generate(
        coordsJSON.length,
        (i) => GeoJSONPosition(
            newLongitude: coordsJSON[i]['longitude'],
            newLatitude: coordsJSON[i]['latitude']));
  }

  @override
  toGeoJSONFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJSON()).toList()
    };
  }

  @override
  toGeoJSON() {
    return {
      'type': type.toShortString(),
      'coordinates': coordinates.map((e) => e.toGeoJSON()).toList()
    };
  }

  @override
  extractLatLng() {
    return coordinates.expand((e) => e.extractLatLng()).toList();
  }
}
