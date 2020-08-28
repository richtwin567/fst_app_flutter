import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/line_string.dart';

class GeoJSONMultiLineString extends GeoJSONGeometryObject {
  List<GeoJSONLineString> coordinates;
  GeoJSONMultiLineString({@required coordsJSON})
      : assert(coordsJSON != null),
        super(GeoJSONGeometryType.MultiLineString) {
    coordinates = [];
    var lineStringCoords = [];
    for (var i = 0; i < coordsJSON.length; i++) {
      if (coordsJSON[i]['marker'] == 'END') {
        lineStringCoords.add(coordsJSON[i]);
        coordinates.add(GeoJSONLineString(coordsJSON: lineStringCoords));
        lineStringCoords = [];
      } else {
        lineStringCoords.add(coordsJSON[i]);
      }
    }
  }

  @override
  toGeoJSONFile() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJSONFile()).toList()
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
    return coordinates.expand((e) => e.extractLatLng());
  }
}
