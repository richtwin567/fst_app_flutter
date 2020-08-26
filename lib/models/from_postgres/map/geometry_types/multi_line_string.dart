import 'package:flutter/material.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_object.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/geometry_type.dart';
import 'package:fst_app_flutter/models/from_postgres/map/geometry_types/line_string.dart';

class MultiLineString extends GeometryObject {
  List<LineString> coordinates;
  MultiLineString({@required coordsJSON})
      : assert(coordsJSON != null),
        super(GeometryType.MultiLineString) {
    coordinates = [];
    var lineStringCoords = [];
    for (var i = 0; i < coordsJSON.length; i++) {
      if (coordsJSON[i]['marker'] == 'END') {
        lineStringCoords.add(coordsJSON[i]);
        coordinates.add(LineString(coordsJSON: lineStringCoords));
        lineStringCoords = [];
      } else {
        lineStringCoords.add(coordsJSON[i]);
      }
    }
  }

  @override
  toGeoJSON() {
    return {
      '\"type\"': '\"${type.toShortString()}\"',
      '\"coordinates\"': coordinates.map((e) => e.toGeoJSON()).toList()
    };
  }
}
