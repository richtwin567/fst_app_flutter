import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/position.dart';

class GeoJsonLineString extends GeoJsonGeometryObject {
  List<GeoJsonPosition> _coordinates;

  List<GeoJsonPosition> get coordinates => _coordinates;

  GeoJsonLineString({@required coordsJson})
      : assert(coordsJson != null),
        assert(coordsJson.length >= 2),
        super(GeoJsonGeometryType.lineString) {
    _coordinates = List.generate(
        coordsJson.length,
        (i) => GeoJsonPosition(
            newLongitude: coordsJson[i]['longitude'],
            newLatitude: coordsJson[i]['latitude']));
  }

  @override
  toGeoJsonFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJson()).toList()
    };
  }

  @override
  toGeoJson() {
    return {
      'type': type.toShortString(),
      'coordinates': coordinates.map((e) => e.toGeoJson()).toList()
    };
  }

  @override
  extractLatLng() {
    return coordinates.expand((e) => e.extractLatLng()).toList();
  }
}
